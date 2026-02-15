/**
 * Seed script to populate Strapi with CV data.
 * Usage: STRAPI_API_TOKEN=<token> node scripts/seed.js
 */

const BASE = process.env.STRAPI_URL || "http://localhost:1337";
const TOKEN = process.env.STRAPI_API_TOKEN;

if (!TOKEN) {
  console.error("STRAPI_API_TOKEN env var is required");
  process.exit(1);
}

const headers = {
  "Content-Type": "application/json",
  Authorization: `Bearer ${TOKEN}`,
};

async function create(endpoint, data) {
  const url = `${BASE}/api/${endpoint}`;
  const res = await fetch(url, {
    method: "POST",
    headers,
    body: JSON.stringify({ data }),
  });
  const json = await res.json();
  if (json.error) {
    console.error(`  FAIL ${endpoint}:`, json.error.message);
    return null;
  }
  console.log(`  OK ${endpoint}: ${json.data?.id || "created"}`);
  return json.data;
}

async function update(endpoint, data) {
  const url = `${BASE}/api/${endpoint}`;
  const res = await fetch(url, {
    method: "PUT",
    headers,
    body: JSON.stringify({ data }),
  });
  const json = await res.json();
  if (json.error) {
    console.error(`  FAIL ${endpoint}:`, json.error.message);
    return null;
  }
  console.log(`  OK ${endpoint}: updated`);
  return json.data;
}

async function seedProfile() {
  console.log("\n--- Profile ---");
  await update("profile", {
    name: "Lucas Albini",
    designation: "Tech Lead em IA",
    company: "Atos",
    location: "Curitiba, Paran\u00e1, Brasil",
    summary:
      "Tech Lead com s\u00f3lida experi\u00eancia em desenvolvimento e arquitetura de solu\u00e7\u00f5es de Intelig\u00eancia Artificial end-to-end. Especialista em liderar times de forma estrat\u00e9gica para constru\u00e7\u00e3o de aplica\u00e7\u00f5es complexas envolvendo IA Generativa, Large Language Models (LLMs), RAG, Vis\u00e3o Computacional e Machine Learning.\n\nApaixonado por tecnologia desde crian\u00e7a, busco constantemente aplicar IA de forma pr\u00e1tica para resolver problemas reais de neg\u00f3cio, mantendo sempre o foco em qualidade, escalabilidade e melhores pr\u00e1ticas de engenharia.",
    typing_titles: [
      "Tech Lead em IA",
      "Especialista em GenAI",
      "4x AWS Certified",
      "Computer Vision Engineer",
      "Machine Learning Engineer",
    ],
    social_links: [
      { platform: "linkedin", url: "https://www.linkedin.com/in/lucasalbini" },
      { platform: "github", url: "https://github.com/lucasalbini" },
      { platform: "email", url: "mailto:lucasalbini@outlook.com" },
    ],
    soft_skills: [
      { name: "Lideran\u00e7a T\u00e9cnica" },
      { name: "Arquitetura de Solu\u00e7\u00f5es" },
      { name: "Gest\u00e3o de Equipe" },
      { name: "Comunica\u00e7\u00e3o com Stakeholders" },
      { name: "Resolu\u00e7\u00e3o de Problemas" },
      { name: "Colabora\u00e7\u00e3o Internacional" },
    ],
  });
}

async function seedExperiences() {
  console.log("\n--- Experiences ---");

  // Atos
  await create("experiences", {
    company_name: "Atos",
    company_url: "https://atos.net",
    company_location: "S\u00e3o Paulo, Brasil",
    order: 1,
    positions: [
      {
        designation: "L\u00edder T\u00e9cnico de IA",
        start_date: "2025-11-01",
        end_date: null,
        is_current: true,
        responsibilities: [
          { description: "Defini\u00e7\u00e3o da arquitetura das solu\u00e7\u00f5es desde as primeiras discuss\u00f5es do projeto" },
          { description: "Conversas diretas com clientes e equipes internas para entender necessidades e traduzir em requisitos claros" },
          { description: "Implanta\u00e7\u00e3o de pipelines de CI/CD, padr\u00f5es de c\u00f3digo, testes automatizados e boas pr\u00e1ticas no GitHub" },
          { description: "Gerenciamento dos reposit\u00f3rios dos projetos, workflows e versionamento" },
          { description: "Revis\u00e3o de c\u00f3digo e acompanhamento da qualidade das entregas" },
          { description: "Integra\u00e7\u00e3o e colabora\u00e7\u00e3o com times internacionais (principalmente Argentina)" },
        ],
      },
      {
        designation: "Engenheiro de Machine Learning Senior",
        start_date: "2024-10-01",
        end_date: "2025-11-01",
        is_current: false,
        responsibilities: [
          { description: "Desenvolvimento de solu\u00e7\u00f5es end-to-end de IA em cloud (AWS, Azure, GCP) para clientes corporativos" },
          { description: "Plataformas de An\u00e1lise Documental com classifica\u00e7\u00e3o, extra\u00e7\u00e3o e resumo automatizado com LLMs" },
          { description: "Aplica\u00e7\u00f5es de An\u00e1lise de Atendimento com Azure Speech + Azure OpenAI" },
          { description: "Solu\u00e7\u00f5es RAG e Chatbots Corporativos com arquitetura h\u00edbrida Neo4j + busca vetorial" },
          { description: "Vis\u00e3o Computacional para Vistorias com detec\u00e7\u00e3o e extra\u00e7\u00e3o de informa\u00e7\u00f5es em imagens" },
        ],
      },
      {
        designation: "Engenheiro de Machine Learning Pleno",
        start_date: "2023-07-01",
        end_date: "2024-10-01",
        is_current: false,
        responsibilities: [
          { description: "Desenvolvimento de solu\u00e7\u00f5es cloud-native focadas em LLMs, NLP, RAG e processamento de documentos" },
          { description: "Chatbots jur\u00eddicos com RAG para verifica\u00e7\u00e3o de conformidade normativa" },
          { description: "Plataformas de extra\u00e7\u00e3o de cl\u00e1usulas cr\u00edticas e an\u00e1lise de contratos com LLMs" },
          { description: "Clusteriza\u00e7\u00e3o de tickets com lemmatiza\u00e7\u00e3o, embeddings e extra\u00e7\u00e3o de t\u00f3picos" },
          { description: "Sistemas de detec\u00e7\u00e3o de ocorr\u00eancias e alertas automatizados" },
        ],
      },
      {
        designation: "Engenheiro de Vis\u00e3o Computacional Pleno",
        start_date: "2021-05-01",
        end_date: "2023-07-01",
        is_current: false,
        responsibilities: [
          { description: "Desenvolvimento e deploy de solu\u00e7\u00f5es completas de vis\u00e3o computacional para setores aliment\u00edcio, energia, varejo, sa\u00fade e log\u00edstica" },
          { description: "Detec\u00e7\u00e3o e classifica\u00e7\u00e3o de produtos em linhas de produ\u00e7\u00e3o e controle de qualidade" },
          { description: "Detec\u00e7\u00e3o de EPIs, monitoramento de seguran\u00e7a e compliance no setor de energia" },
          { description: "Sistema completo de reconhecimento facial com reidentifica\u00e7\u00e3o em tempo real" },
          { description: "Extra\u00e7\u00e3o autom\u00e1tica de dados via OCR para sa\u00fade e setor financeiro" },
        ],
      },
    ],
  });

  // 33Robotics
  await create("experiences", {
    company_name: "33Robotics",
    company_url: null,
    company_location: "Curitiba, Brasil",
    order: 2,
    positions: [
      {
        designation: "Computer Vision Developer",
        start_date: "2019-10-01",
        end_date: "2021-06-01",
        is_current: false,
        responsibilities: [
          { description: "Navega\u00e7\u00e3o aut\u00f4noma de rob\u00f4s com odometria visual e reconhecimento de objetos usando c\u00e2meras de profundidade e lidars" },
          { description: "Desenvolvimento de produto para reciclagem autom\u00e1tica de res\u00edduos residenciais com redes neurais convolucionais" },
          { description: "Projeto de aux\u00edlio ao COVID-19: totem de medi\u00e7\u00e3o de temperatura, classifica\u00e7\u00e3o de uso de m\u00e1scara e contagem de pessoas" },
        ],
      },
    ],
  });

  // UTFPR
  await create("experiences", {
    company_name: "Federal University of Technology - Paran\u00e1 (UTFPR)",
    company_url: "https://www.utfpr.edu.br",
    company_location: "Curitiba, Brasil",
    order: 3,
    positions: [
      {
        designation: "Undergraduate Research Assistant",
        start_date: "2017-08-01",
        end_date: "2020-05-01",
        is_current: false,
        responsibilities: [
          { description: "Pesquisa em interpreta\u00e7\u00e3o sem\u00e2ntica de imagens e v\u00eddeos com deep learning no LABIC" },
          { description: "Classifica\u00e7\u00e3o de marca e modelo de ve\u00edculos com redes neurais convolucionais" },
          { description: "Segmenta\u00e7\u00e3o de carroceria de ve\u00edculos com Gene Expression Programming" },
          { description: "Classifica\u00e7\u00e3o de aves de rapina brasileiras com Deep Neural Networks" },
        ],
      },
      {
        designation: "Estagi\u00e1rio",
        start_date: "2017-04-01",
        end_date: "2017-08-01",
        is_current: false,
        responsibilities: [
          { description: "Configura\u00e7\u00e3o e manuten\u00e7\u00e3o de microcomputadores, redes e servidores web no LABIC" },
          { description: "Rotulagem de bancos de dados para projetos de pesquisa" },
        ],
      },
    ],
  });

  // Martin Brower
  await create("experiences", {
    company_name: "Martin Brower",
    company_url: null,
    company_location: "S\u00e3o Paulo, Brasil",
    order: 4,
    positions: [
      {
        designation: "Estagi\u00e1rio",
        start_date: "2018-02-01",
        end_date: "2018-03-01",
        is_current: false,
        responsibilities: [
          { description: "Vencedor do desafio MB University Award - desenvolvimento de business case para ferramenta de gest\u00e3o log\u00edstica" },
          { description: "Ferramenta para controle de temperatura, frota de caminh\u00f5es, roteiriza\u00e7\u00e3o e otimiza\u00e7\u00e3o de pallets" },
        ],
      },
    ],
  });
}

async function seedEducation() {
  console.log("\n--- Education ---");
  await create("educations", {
    institution: "Federal University of Technology - Paran\u00e1 (UTFPR)",
    degree: "Bacharelado",
    field_of_study: "Engenharia Mec\u00e2nica",
    start_date: "2014-01-01",
    end_date: "2021-12-01",
    description:
      "Forma\u00e7\u00e3o em Engenharia Mec\u00e2nica com foco em pesquisa em Vis\u00e3o Computacional e Intelig\u00eancia Artificial no Laborat\u00f3rio de Bioinform\u00e1tica e Intelig\u00eancia Computacional (LABIC).",
  });
}

async function seedSkills() {
  console.log("\n--- Skills ---");
  const skills = [
    // Languages
    { name: "Python", icon_name: "SiPython", category: "language" },
    { name: "TypeScript", icon_name: "SiTypescript", category: "language" },
    { name: "Go", icon_name: "SiGo", category: "language" },

    // Frameworks
    { name: "FastAPI", icon_name: "SiFastapi", category: "framework" },
    { name: "React", icon_name: "SiReact", category: "framework" },
    { name: "Next.js", icon_name: "SiNextdotjs", category: "framework" },
    { name: "LangChain", icon_name: null, category: "framework" },
    { name: "LlamaIndex", icon_name: null, category: "framework" },

    // Cloud
    { name: "AWS", icon_name: "SiAmazonwebservices", category: "cloud" },
    { name: "Azure", icon_name: "SiMicrosoftazure", category: "cloud" },
    { name: "GCP", icon_name: "SiGooglecloud", category: "cloud" },

    // AI/ML
    { name: "TensorFlow", icon_name: "SiTensorflow", category: "ai_ml" },
    { name: "PyTorch", icon_name: "SiPytorch", category: "ai_ml" },
    { name: "OpenCV", icon_name: "SiOpencv", category: "ai_ml" },
    { name: "YOLO", icon_name: null, category: "ai_ml" },
    { name: "OpenAI API", icon_name: null, category: "ai_ml" },
    { name: "Anthropic Claude", icon_name: null, category: "ai_ml" },

    // DevOps
    { name: "Docker", icon_name: "SiDocker", category: "devops" },
    { name: "Kubernetes", icon_name: "SiKubernetes", category: "devops" },
    { name: "GitHub Actions", icon_name: null, category: "devops" },
    { name: "SonarQube", icon_name: null, category: "devops" },
  ];

  for (const skill of skills) {
    await create("skills", skill);
  }
}

async function seedCertifications() {
  console.log("\n--- Certifications ---");
  const certs = [
    {
      name: "AWS Certified Machine Learning - Specialty",
      issuer: "Amazon Web Services",
      issue_date: null,
      credential_url: null,
    },
    {
      name: "AWS Certified Solutions Architect - Associate",
      issuer: "Amazon Web Services",
      issue_date: null,
      credential_url: null,
    },
    {
      name: "AWS Certified Developer - Associate",
      issuer: "Amazon Web Services",
      issue_date: null,
      credential_url: null,
    },
    {
      name: "AWS Certified Cloud Practitioner",
      issuer: "Amazon Web Services",
      issue_date: null,
      credential_url: null,
    },
    {
      name: "Microsoft Azure - Introduction to Artificial Intelligence",
      issuer: "Microsoft",
      issue_date: null,
      credential_url: null,
    },
    {
      name: "Machine Learning and Data Science with Python",
      issuer: null,
      issue_date: null,
      credential_url: null,
    },
  ];

  for (const cert of certs) {
    await create("certifications", cert);
  }
}

async function seedPublications() {
  console.log("\n--- Publications ---");
  const pubs = [
    {
      title:
        "A Gene Expression Programming Approach for Vehicle Body Segmentation and Color Recognition",
      authors: "Lucas Albini et al.",
      journal: null,
      date: null,
      url: null,
      doi: null,
      abstract:
        "Aplica\u00e7\u00e3o de Gene Expression Programming para segmenta\u00e7\u00e3o de carroceria de ve\u00edculos e reconhecimento de cores.",
    },
    {
      title: "Deep Learning for Brazilian Car Make and Model Recognition",
      authors: "Lucas Albini et al.",
      journal: null,
      date: null,
      url: null,
      doi: null,
      abstract:
        "Sistema de classifica\u00e7\u00e3o de marca e modelo de carros brasileiros utilizando deep learning atrav\u00e9s de c\u00e2meras de seguran\u00e7a.",
    },
    {
      title:
        "Brazilian Birds of Prey - A New Dataset and Classification with Deep Neural Networks",
      authors: "Lucas Albini et al.",
      journal: null,
      date: null,
      url: null,
      doi: null,
      abstract:
        "Novo dataset e classifica\u00e7\u00e3o de aves de rapina brasileiras utilizando redes neurais profundas.",
    },
  ];

  for (const pub of pubs) {
    await create("publications", pub);
  }
}

async function publishAll() {
  console.log("\n--- Publishing all content ---");
  const collections = [
    "experiences",
    "educations",
    "skills",
    "certifications",
    "publications",
  ];

  for (const col of collections) {
    const res = await fetch(`${BASE}/api/${col}?status=draft&pagination[pageSize]=100`, { headers });
    const json = await res.json();
    if (json.data) {
      for (const item of json.data) {
        const pubRes = await fetch(`${BASE}/api/${col}/${item.documentId}`, {
          method: "PUT",
          headers,
          body: JSON.stringify({ data: { ...item, publishedAt: new Date().toISOString() } }),
        });
        const pubJson = await pubRes.json();
        if (pubJson.error) {
          console.error(`  FAIL publish ${col}/${item.documentId}:`, pubJson.error.message);
        }
      }
      console.log(`  OK published ${json.data.length} ${col}`);
    }
  }

  // Profile is a single type
  const profileRes = await fetch(`${BASE}/api/profile?status=draft`, { headers });
  const profileJson = await profileRes.json();
  if (profileJson.data) {
    await fetch(`${BASE}/api/profile`, {
      method: "PUT",
      headers,
      body: JSON.stringify({ data: { ...profileJson.data, publishedAt: new Date().toISOString() } }),
    });
    console.log("  OK published profile");
  }
}

async function main() {
  console.log("Seeding Strapi with CV data...\n");

  await seedProfile();
  await seedExperiences();
  await seedEducation();
  await seedSkills();
  await seedCertifications();
  await seedPublications();
  await publishAll();

  console.log("\nDone! All content seeded.");
}

main().catch(console.error);
