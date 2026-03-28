import { useState } from 'react';
import { ExternalLink, Github, Play, Apple, Share2 } from 'lucide-react';
import projectsData from '../../imports/projects.json';
import { ProjectModal } from './ProjectModal';

export function Projects() {
  const [selectedProject, setSelectedProject] = useState<any>(null);
  const [filter, setFilter] = useState('All');

  const categories = ['All', ...Array.from(new Set(projectsData.map(p => p.category)))];

  const filteredProjects = filter === 'All' 
    ? projectsData 
    : projectsData.filter(p => p.category === filter);

  const handleShare = async (project: any, e: React.MouseEvent) => {
    e.stopPropagation();
    
    const shareData = {
      title: project.title,
      text: `Check out ${project.title} - ${project.description}`,
      url: project.store || project.appStore || project.github || project.live || window.location.href,
    };

    try {
      if (navigator.share) {
        await navigator.share(shareData);
      } else {
        // Fallback: copy to clipboard
        await navigator.clipboard.writeText(shareData.url);
        alert('Link copied to clipboard!');
      }
    } catch (err) {
      console.error('Error sharing:', err);
    }
  };

  return (
    <section id="projects" className="py-24 bg-white dark:bg-gray-950 relative overflow-hidden">
      {/* Decorative Background Elements */}
      <div className="absolute top-1/4 -right-20 w-80 h-80 bg-blue-500/5 rounded-full blur-[100px]"></div>
      <div className="absolute bottom-1/4 -left-20 w-80 h-80 bg-indigo-500/5 rounded-full blur-[100px]"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="text-center mb-16">
          <h2 className="text-4xl sm:text-6xl font-black mb-4 text-gray-900 dark:text-white tracking-tight">
            <span className="text-gradient">Featured Projects</span>
          </h2>
          <div className="w-24 h-1.5 bg-gradient-to-r from-blue-600 to-indigo-600 mx-auto mb-10 rounded-full shadow-sm"></div>

          {/* Category Filter */}
          <div className="flex flex-wrap justify-center gap-3">
            {categories.map((category) => (
              <button
                key={category}
                onClick={() => setFilter(category)}
                className={`px-8 py-2.5 rounded-2xl transition-all duration-300 font-semibold tracking-wide ${
                  filter === category
                    ? 'bg-gradient-to-r from-blue-600 to-indigo-600 text-white shadow-xl shadow-blue-500/20 scale-105'
                    : 'glass-card text-gray-600 dark:text-gray-400 hover:bg-blue-50 dark:hover:bg-gray-800'
                }`}
              >
                {category}
              </button>
            ))}
          </div>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-10">
          {filteredProjects.map((project) => (
            <div
              key={project.id}
              className="glass-card hover-lift group cursor-pointer overflow-hidden rounded-[2rem] border-white/40 dark:border-gray-800/50"
              onClick={() => setSelectedProject(project)}
            >
              <div className="relative h-56 overflow-hidden">
                {!project.image ? (
                  <div className="w-full h-full bg-gradient-to-br from-blue-600/90 to-indigo-700/90 flex flex-col items-center justify-center gap-3 group-hover:scale-110 transition-transform duration-700">
                    <span className="text-6xl font-black text-white/20 select-none">{project.title.charAt(0)}</span>
                    <span className="text-white/60 text-xs font-bold uppercase tracking-[0.2em]">{project.category}</span>
                  </div>
                ) : project.image?.endsWith('.mp4') ? (
                  <>
                    <video
                      src={project.image}
                      className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                      muted
                      loop
                      playsInline
                      onMouseEnter={(e) => (e.currentTarget as HTMLVideoElement).play()}
                      onMouseLeave={(e) => { (e.currentTarget as HTMLVideoElement).pause(); (e.currentTarget as HTMLVideoElement).currentTime = 0; }}
                    />
                    <div className="absolute inset-0 bg-black/20 group-hover:bg-transparent transition-colors duration-500"></div>
                    <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
                      <div className="w-14 h-14 bg-white/20 backdrop-blur-md rounded-full flex items-center justify-center border border-white/30 group-hover:scale-125 group-hover:bg-blue-600 transition-all duration-500">
                        <Play className="w-6 h-6 text-white ml-1 fill-white" />
                      </div>
                    </div>
                  </>
                ) : (
                  <img
                    src={project.image}
                    alt={project.title}
                    className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                  />
                )}
                <div className="absolute top-5 right-5 px-4 py-1.5 glass-morphism text-white rounded-full text-xs font-bold tracking-widest uppercase">
                  {project.category}
                </div>
              </div>

              <div className="p-8">
                <h3 className="text-2xl font-bold text-gray-900 dark:text-white mb-3 group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors">
                  {project.title}
                </h3>
                <p className="text-gray-600 dark:text-gray-400 mb-6 line-clamp-2 leading-relaxed text-sm">
                  {project.description}
                </p>

                {/* Technologies */}
                <div className="flex flex-wrap gap-2 mb-8">
                  {project.technologies.slice(0, 3).map((tech: string, idx: number) => (
                    <span
                      key={idx}
                      className="px-3.5 py-1.5 bg-blue-500/5 dark:bg-blue-400/5 text-blue-600 dark:text-blue-400 rounded-xl text-xs font-bold border border-blue-500/10 dark:border-blue-400/10"
                    >
                      {tech}
                    </span>
                  ))}
                  {project.technologies.length > 3 && (
                    <span className="px-3 py-1.5 bg-gray-500/5 text-gray-500 rounded-xl text-xs font-bold">
                      +{project.technologies.length - 3}
                    </span>
                  )}
                </div>

                {/* Links */}
                <div className="flex items-center gap-3">
                  {project.github && (
                    <a
                      href={project.github}
                      target="_blank"
                      rel="noopener noreferrer"
                      onClick={(e) => e.stopPropagation()}
                      className="w-10 h-10 glass-card flex items-center justify-center rounded-xl hover:bg-gray-900 hover:text-white dark:hover:bg-white dark:hover:text-black transition-all hover:-translate-y-1 active:scale-90"
                      title="GitHub"
                    >
                      <Github size={18} />
                    </a>
                  )}
                  {project.store && (
                    <a
                      href={project.store}
                      target="_blank"
                      rel="noopener noreferrer"
                      onClick={(e) => e.stopPropagation()}
                      className="w-10 h-10 glass-card flex items-center justify-center rounded-xl hover:bg-green-600 hover:text-white transition-all hover:-translate-y-1 active:scale-90"
                      title="Play Store"
                    >
                      <Play size={18} className="ml-0.5 fill-current" />
                    </a>
                  )}
                  {project.appStore && (
                    <a
                      href={project.appStore}
                      target="_blank"
                      rel="noopener noreferrer"
                      onClick={(e) => e.stopPropagation()}
                      className="w-10 h-10 glass-card flex items-center justify-center rounded-xl hover:bg-gray-900 hover:text-white dark:hover:bg-white dark:hover:text-black transition-all hover:-translate-y-1 active:scale-90"
                      title="App Store"
                    >
                      <Apple size={18} />
                    </a>
                  )}
                  {project.live && (
                    <a
                      href={project.live}
                      target="_blank"
                      rel="noopener noreferrer"
                      onClick={(e) => e.stopPropagation()}
                      className="w-10 h-10 glass-card flex items-center justify-center rounded-xl hover:bg-blue-600 hover:text-white transition-all hover:-translate-y-1 active:scale-90"
                      title="Live Demo"
                    >
                      <ExternalLink size={18} />
                    </a>
                  )}
                  <div className="flex-grow"></div>
                  <button
                    onClick={(e) => handleShare(project, e)}
                    className="w-10 h-10 glass-card flex items-center justify-center rounded-xl hover:bg-indigo-600 hover:text-white transition-all hover:-translate-y-1 active:scale-90"
                    title="Share Project"
                  >
                    <Share2 size={18} />
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Project Modal */}
      {selectedProject && (
        <ProjectModal
          project={selectedProject}
          onClose={() => setSelectedProject(null)}
        />
      )}
    </section>
  );
}