const BASE = "http://localhost:1337";
const TOKEN = process.env.STRAPI_API_TOKEN;
const headers = { "Content-Type": "application/json", Authorization: `Bearer ${TOKEN}` };

async function publishCollection(col) {
  const res = await fetch(`${BASE}/api/${col}?status=draft&pagination[pageSize]=100`, { headers });
  const json = await res.json();
  if (!json.data || json.data.length === 0) {
    console.log(`${col}: nothing to publish`);
    return;
  }
  for (const item of json.data) {
    const r = await fetch(`${BASE}/api/${col}/${item.documentId}`, {
      method: "PUT",
      headers,
      body: JSON.stringify({ data: { publishedAt: new Date().toISOString() } }),
    });
    const j = await r.json();
    if (j.error) console.error("FAIL", col, item.documentId, j.error.message);
  }
  console.log(`Published ${json.data.length} ${col}`);
}

async function main() {
  const collections = ["experiences", "educations", "skills", "certifications", "publications"];
  for (const col of collections) {
    await publishCollection(col);
  }
  // Profile single type
  await fetch(`${BASE}/api/profile`, {
    method: "PUT",
    headers,
    body: JSON.stringify({ data: { publishedAt: new Date().toISOString() } }),
  });
  console.log("Published profile");
}

main().catch(console.error);
