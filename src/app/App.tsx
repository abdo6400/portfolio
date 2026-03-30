import { BrowserRouter, Routes, Route } from 'react-router';
import { Navigation } from './components/Navigation';
import { ThemeProvider } from './components/ThemeProvider';
import { ChatAssistant } from '../modules/ai-assistant';
import { ProfileViews } from './components/ProfileViews';
import { HomePage } from './pages/HomePage';
import { AboutPage } from './pages/AboutPage';
import { SkillsPage } from './pages/SkillsPage';
import { ExperiencePage } from './pages/ExperiencePage';
import { ProjectsPage } from './pages/ProjectsPage';
import { ContactPage } from './pages/ContactPage';

export default function App() {
  return (
    <ThemeProvider>
      <BrowserRouter basename="/portfolio">
        <div className="min-h-screen bg-gray-50 dark:bg-gray-900 transition-colors">
          <Navigation />
          <main>
            <Routes>
              <Route path="/" element={<HomePage />} />
              <Route path="/about" element={<AboutPage />} />
              <Route path="/skills" element={<SkillsPage />} />
              <Route path="/experience" element={<ExperiencePage />} />
              <Route path="/projects" element={<ProjectsPage />} />
              <Route path="/contact" element={<ContactPage />} />
            </Routes>
          </main>
          <footer className="bg-gray-900 dark:bg-black text-white py-8">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
              <p>&copy; 2026 Abdulrahman Amr. All rights reserved.</p>
            </div>
          </footer>
          <ChatAssistant />
          <ProfileViews />
        </div>
      </BrowserRouter>
    </ThemeProvider>
  );
}
