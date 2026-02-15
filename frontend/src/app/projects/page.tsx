import { Navbar } from "@/components/layout/Navbar";
import { Footer } from "@/components/layout/Footer";
import { ScrollToTop } from "@/components/layout/ScrollToTop";
import { ProjectsSection } from "@/components/sections/ProjectsSection";
import { getProjects } from "@/lib/api";

export const metadata = {
  title: "Projetos - Lucas Albini",
  description: "Portfolio de projetos de Lucas Albini",
};

export default async function ProjectsPage() {
  let projects;
  try {
    projects = await getProjects();
  } catch {
    projects = { data: [] };
  }

  return (
    <>
      <Navbar />
      <main className="pt-16">
        <ProjectsSection projects={projects?.data || []} showAll />
      </main>
      <Footer />
      <ScrollToTop />
    </>
  );
}
