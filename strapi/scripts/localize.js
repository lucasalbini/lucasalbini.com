/**
 * Creates pt-BR localizations for all existing content (currently in "en").
 * Usage: STRAPI_API_TOKEN=<token> node scripts/localize.js
 */

const BASE = "http://localhost:1337";
const TOKEN = process.env.STRAPI_API_TOKEN;
const headers = {
  "Content-Type": "application/json",
  Authorization: `Bearer ${TOKEN}`,
};

async function localizeCollection(collection) {
  const res = await fetch(
    `${BASE}/api/${collection}?locale=en&pagination[pageSize]=100&populate=*`,
    { headers }
  );
  const json = await res.json();
  if (!json.data || json.data.length === 0) {
    console.log(`  ${collection}: no content to localize`);
    return;
  }

  for (const item of json.data) {
    const { id, documentId, createdAt, updatedAt, publishedAt, locale, localizations, ...fields } = item;

    // Clean nested components (remove ids)
    const cleanedFields = cleanFields(fields);

    const r = await fetch(`${BASE}/api/${collection}/${documentId}`, {
      method: "PUT",
      headers,
      body: JSON.stringify({
        data: { ...cleanedFields, locale: "pt-BR", publishedAt: new Date().toISOString() },
      }),
    });
    const result = await r.json();
    if (result.error) {
      console.error(`  FAIL ${collection}/${documentId}:`, result.error.message, JSON.stringify(result.error.details).substring(0, 200));
    } else {
      console.log(`  OK ${collection}/${documentId}`);
    }
  }
  console.log(`  Localized ${json.data.length} ${collection}`);
}

async function localizeProfile() {
  const res = await fetch(`${BASE}/api/profile?locale=en&populate=*`, { headers });
  const json = await res.json();
  if (!json.data) {
    console.log("  profile: no content");
    return;
  }

  const { id, documentId, createdAt, updatedAt, publishedAt, locale, localizations, ...fields } = json.data;
  const cleanedFields = cleanFields(fields);

  const r = await fetch(`${BASE}/api/profile`, {
    method: "PUT",
    headers,
    body: JSON.stringify({
      data: { ...cleanedFields, locale: "pt-BR", publishedAt: new Date().toISOString() },
    }),
  });
  const result = await r.json();
  if (result.error) {
    console.error("  FAIL profile:", result.error.message, JSON.stringify(result.error.details).substring(0, 200));
  } else {
    console.log("  OK profile");
  }
}

function cleanFields(obj) {
  if (Array.isArray(obj)) {
    return obj.map(cleanFields);
  }
  if (obj && typeof obj === "object") {
    const cleaned = {};
    for (const [key, value] of Object.entries(obj)) {
      if (["id", "documentId", "createdAt", "updatedAt", "publishedAt", "locale", "localizations"].includes(key)) continue;
      cleaned[key] = cleanFields(value);
    }
    return cleaned;
  }
  return obj;
}

async function main() {
  console.log("Creating pt-BR localizations...\n");

  console.log("--- Profile ---");
  await localizeProfile();

  const collections = ["experiences", "educations", "skills", "certifications", "publications"];
  for (const col of collections) {
    console.log(`\n--- ${col} ---`);
    await localizeCollection(col);
  }

  console.log("\nDone!");
}

main().catch(console.error);
