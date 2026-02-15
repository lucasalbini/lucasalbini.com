import { Navbar } from "@/components/layout/Navbar";
import { Footer } from "@/components/layout/Footer";
import { ScrollToTop } from "@/components/layout/ScrollToTop";
import { HeroSection } from "@/components/sections/HeroSection";
import { AboutSection } from "@/components/sections/AboutSection";
import { SkillsSection } from "@/components/sections/SkillsSection";
import { ExperienceSection } from "@/components/sections/ExperienceSection";
import { EducationSection } from "@/components/sections/EducationSection";
import { ProjectsSection } from "@/components/sections/ProjectsSection";
import { PublicationsSection } from "@/components/sections/PublicationsSection";
import { BlogSection } from "@/components/sections/BlogSection";
import {
  getProfile,
  getExperiences,
  getEducation,
  getSkills,
  getCertifications,
  getProjects,
  getPosts,
  getPublications,
} from "@/lib/api";

export default async function HomePage() {
  let profile, experiences, education, skills, certifications, projects, posts, publications;

  try {
    [profile, experiences, education, skills, certifications, projects, posts, publications] =
      await Promise.all([
        getProfile(),
        getExperiences(),
        getEducation(),
        getSkills(),
        getCertifications(),
        getProjects(),
        getPosts("pt", 1, 6),
        getPublications(),
      ]);
  } catch {
    // Fallback with empty data when API is not available
    profile = { data: null };
    experiences = { data: [] };
    education = { data: [] };
    skills = { data: [] };
    certifications = { data: [] };
    projects = { data: [] };
    posts = { data: [] };
    publications = { data: [] };
  }

  const profileData = profile?.data;
  const fallbackProfile = {
    id: 0,
    name: "Lucas Albini",
    designation: "Tech Lead em IA",
    company: "Atos",
    location: "Curitiba, Paraná, Brasil",
    summary: "",
    typing_titles: [
      "Tech Lead em IA",
      "Especialista em GenAI",
      "4x AWS Certified",
      "Computer Vision Engineer",
    ],
    social_links: [
      { id: 1, platform: "LinkedIn", url: "https://www.linkedin.com/in/lucasalbini" },
      { id: 2, platform: "Email", url: "lucasalbini@outlook.com" },
    ],
    soft_skills: [],
  };

  return (
    <>
      <Navbar />
      <main>
        <HeroSection profile={profileData || fallbackProfile} />
        <AboutSection
          profile={profileData || fallbackProfile}
          certifications={certifications?.data || []}
        />
        <SkillsSection skills={skills?.data || []} />
        <ExperienceSection experiences={experiences?.data || []} />
        <EducationSection education={education?.data || []} />
        <ProjectsSection projects={projects?.data || []} />
        <PublicationsSection publications={publications?.data || []} />
        <BlogSection posts={posts?.data || []} />
      </main>
      <Footer />
      <ScrollToTop />
    </>
  );
}
