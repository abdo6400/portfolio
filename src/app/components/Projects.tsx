import { useState, useRef, useEffect } from 'react';
import { ExternalLink, Github, Play, Apple, Share2, Eye, ChevronRight, MessageCircle } from 'lucide-react';
import projectsData from '../../imports/projects.json';
import { ProjectModal } from './ProjectModal';

export function Projects() {
  const [selectedProject, setSelectedProject] = useState<any>(null);
  const [filter, setFilter] = useState('All');
  const [hoveredCard, setHoveredCard] = useState<number | null>(null);
  const [imageLoaded, setImageLoaded] = useState<Record<number, boolean>>({});

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
        await navigator.clipboard.writeText(shareData.url);
        alert('Link copied to clipboard!');
      }
    } catch (err) {
      console.error('Error sharing:', err);
    }
  };

  const handleImageLoad = (projectId: number) => {
    setImageLoaded(prev => ({ ...prev, [projectId]: true }));
  };

  const handleWhatsAppOrder = (project: any, e: React.MouseEvent) => {
    e.stopPropagation();
    const phoneNumber = '201069645711'; // WhatsApp number
    const message = encodeURIComponent(
      `Hello! I'm interested in ordering a project similar to: ${project.title}\n\nProject Description: ${project.description}\n\nPlease provide more details about pricing and timeline.`
    );
    const whatsappUrl = `https://wa.me/${phoneNumber}?text=${message}`;
    window.open(whatsappUrl, '_blank');
  };

  return (
    <section id="projects" className="py-24 bg-white dark:bg-gray-950 relative overflow-hidden">
      {/* Decorative Background Elements */}
      <div className="absolute top-1/4 -right-20 w-80 h-80 bg-blue-500/5 rounded-full blur-[100px]"></div>
      <div className="absolute bottom-1/4 -left-20 w-80 h-80 bg-indigo-500/5 rounded-full blur-[100px]"></div>
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-purple-500/3 rounded-full blur-[120px]"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="text-center mb-16">
          <div className="inline-flex items-center gap-2 px-4 py-2 bg-blue-500/10 dark:bg-blue-500/20 rounded-full mb-6">
            <span className="w-2 h-2 bg-blue-500 rounded-full animate-pulse"></span>
            <span className="text-blue-600 dark:text-blue-400 text-sm font-semibold">Portfolio</span>
          </div>
          <h2 className="text-4xl sm:text-6xl font-black mb-4 text-gray-900 dark:text-white tracking-tight">
            <span className="text-gradient">Featured Projects</span>
          </h2>
          <p className="text-gray-500 dark:text-gray-400 text-lg max-w-2xl mx-auto mb-8">
            Explore my latest work showcasing innovative solutions and creative designs
          </p>
          <div className="w-24 h-1.5 bg-gradient-to-r from-blue-600 to-indigo-600 mx-auto mb-10 rounded-full shadow-sm"></div>

          {/* Category Filter */}
          <div className="flex flex-wrap justify-center gap-3">
            {categories.map((category) => (
              <button
                key={category}
                onClick={() => setFilter(category)}
                className={`px-6 py-2.5 rounded-2xl transition-all duration-300 font-semibold tracking-wide ${filter === category
                  ? 'bg-gradient-to-r from-blue-600 to-indigo-600 text-white shadow-xl shadow-blue-500/20 scale-105'
                  : 'glass-card text-gray-600 dark:text-gray-400 hover:bg-blue-50 dark:hover:bg-gray-800 hover:scale-105'
                  }`}
              >
                {category}
              </button>
            ))}
          </div>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
          {filteredProjects.map((project, index) => (
            <div
              key={project.id}
              className="glass-card hover-lift group cursor-pointer overflow-hidden rounded-2xl border-white/40 dark:border-gray-800/50 transition-all duration-500 hover:shadow-2xl hover:shadow-blue-500/10 dark:hover:shadow-blue-500/5"
              onClick={() => setSelectedProject(project)}
              onMouseEnter={() => setHoveredCard(project.id)}
              onMouseLeave={() => setHoveredCard(null)}
              style={{ animationDelay: `${index * 100}ms` }}
            >
              <div className="relative h-56 overflow-hidden bg-gray-100 dark:bg-gray-800">
                {/* Loading skeleton */}
                {!imageLoaded[project.id] && (
                  <div className="absolute inset-0 bg-gradient-to-br from-gray-200 to-gray-300 dark:from-gray-700 dark:to-gray-800 animate-pulse">
                    <div className="absolute inset-0 flex items-center justify-center">
                      <div className="w-10 h-10 border-3 border-blue-500/30 border-t-blue-500 rounded-full animate-spin"></div>
                    </div>
                  </div>
                )}

                {!project.image ? (
                  <div className="w-full h-full bg-gradient-to-br from-blue-600/90 to-indigo-700/90 flex flex-col items-center justify-center gap-3 group-hover:scale-110 transition-transform duration-700">
                    <span className="text-6xl font-black text-white/20 select-none">{project.title.charAt(0)}</span>
                    <span className="text-white/60 text-xs font-bold uppercase tracking-[0.2em]">{project.category}</span>
                  </div>
                ) : project.image?.endsWith('.mp4') ? (
                  <>
                    <video
                      src={project.image}
                      className={`w-full h-full object-cover transition-transform duration-700 group-hover:scale-110 ${imageLoaded[project.id] ? 'opacity-100' : 'opacity-0'
                        }`}
                      muted
                      loop
                      playsInline
                      onLoadedData={() => handleImageLoad(project.id)}
                      onMouseEnter={(e) => (e.currentTarget as HTMLVideoElement).play()}
                      onMouseLeave={(e) => { (e.currentTarget as HTMLVideoElement).pause(); (e.currentTarget as HTMLVideoElement).currentTime = 0; }}
                    />
                    <div className="absolute inset-0 bg-black/20 group-hover:bg-transparent transition-colors duration-500"></div>
                    <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
                      <div className="w-14 h-14 bg-white/20 backdrop-blur-md rounded-full flex items-center justify-center border border-white/30 group-hover:scale-125 group-hover:bg-blue-600 transition-all duration-500 shadow-lg">
                        <Play className="w-6 h-6 text-white ml-1 fill-white" />
                      </div>
                    </div>
                  </>
                ) : (
                  <img
                    src={project.image}
                    alt={project.title}
                    className={`w-full h-full object-cover transition-all duration-700 group-hover:scale-110 ${imageLoaded[project.id] ? 'opacity-100' : 'opacity-0'
                      }`}
                    loading="lazy"
                    onLoad={() => handleImageLoad(project.id)}
                  />
                )}

                {/* Overlay gradient */}
                <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>

                {/* Category badge */}
                <div className="absolute top-4 right-4 px-3 py-1.5 glass-morphism text-white rounded-full text-xs font-bold tracking-widest uppercase shadow-lg">
                  {project.category}
                </div>

                {/* Quick view button */}
                <div className="absolute bottom-4 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 translate-y-4 group-hover:translate-y-0 transition-all duration-500">
                  <button className="flex items-center gap-2 px-4 py-2 bg-white/90 dark:bg-gray-900/90 text-gray-900 dark:text-white rounded-full text-sm font-semibold shadow-xl hover:bg-white dark:hover:bg-gray-900 transition-colors">
                    <Eye size={16} />
                    View Details
                    <ChevronRight size={14} className="group-hover:translate-x-1 transition-transform" />
                  </button>
                </div>
              </div>

              <div className="p-6">
                <h3 className="text-xl font-bold text-gray-900 dark:text-white mb-2 group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors line-clamp-1">
                  {project.title}
                </h3>
                <p className="text-gray-600 dark:text-gray-400 mb-5 line-clamp-2 leading-relaxed text-sm">
                  {project.description}
                </p>

                {/* Technologies */}
                <div className="flex flex-wrap gap-2 mb-6">
                  {project.technologies.slice(0, 3).map((tech: string, idx: number) => (
                    <span
                      key={idx}
                      className="px-3 py-1.5 bg-blue-500/5 dark:bg-blue-400/5 text-blue-600 dark:text-blue-400 rounded-lg text-xs font-bold border border-blue-500/10 dark:border-blue-400/10 hover:bg-blue-500/10 hover:border-blue-500/20 transition-colors"
                    >
                      {tech}
                    </span>
                  ))}
                  {project.technologies.length > 3 && (
                    <span className="px-3 py-1.5 bg-gray-500/5 text-gray-500 rounded-lg text-xs font-bold">
                      +{project.technologies.length - 3}
                    </span>
                  )}
                </div>

                {/* Links */}
                <div className="flex items-center gap-2.5">
                  {project.github && (
                    <a
                      href={project.github}
                      target="_blank"
                      rel="noopener noreferrer"
                      onClick={(e) => e.stopPropagation()}
                      className="w-9 h-9 glass-card flex items-center justify-center rounded-lg hover:bg-gray-900 hover:text-white dark:hover:bg-white dark:hover:text-black transition-all hover:-translate-y-1 active:scale-90"
                      title="GitHub"
                    >
                      <Github size={16} />
                    </a>
                  )}
                  {project.store && (
                    <a
                      href={project.store}
                      target="_blank"
                      rel="noopener noreferrer"
                      onClick={(e) => e.stopPropagation()}
                      className="w-9 h-9 glass-card flex items-center justify-center rounded-lg hover:bg-green-600 hover:text-white transition-all hover:-translate-y-1 active:scale-90"
                      title="Play Store"
                    >
                      <Play size={16} className="ml-0.5 fill-current" />
                    </a>
                  )}
                  {project.appStore && (
                    <a
                      href={project.appStore}
                      target="_blank"
                      rel="noopener noreferrer"
                      onClick={(e) => e.stopPropagation()}
                      className="w-9 h-9 glass-card flex items-center justify-center rounded-lg hover:bg-gray-900 hover:text-white dark:hover:bg-white dark:hover:text-black transition-all hover:-translate-y-1 active:scale-90"
                      title="App Store"
                    >
                      <Apple size={16} />
                    </a>
                  )}
                  {project.live && (
                    <a
                      href={project.live}
                      target="_blank"
                      rel="noopener noreferrer"
                      onClick={(e) => e.stopPropagation()}
                      className="w-9 h-9 glass-card flex items-center justify-center rounded-lg hover:bg-blue-600 hover:text-white transition-all hover:-translate-y-1 active:scale-90"
                      title="Live Demo"
                    >
                      <ExternalLink size={16} />
                    </a>
                  )}
                  <div className="flex-grow"></div>
                  <button
                    onClick={(e) => handleWhatsAppOrder(project, e)}
                    className="w-9 h-9 glass-card flex items-center justify-center rounded-lg hover:bg-green-600 hover:text-white transition-all hover:-translate-y-1 active:scale-90"
                    title="Order via WhatsApp"
                  >
                    <MessageCircle size={16} />
                  </button>
                  <button
                    onClick={(e) => handleShare(project, e)}
                    className="w-9 h-9 glass-card flex items-center justify-center rounded-lg hover:bg-indigo-600 hover:text-white transition-all hover:-translate-y-1 active:scale-90"
                    title="Share Project"
                  >
                    <Share2 size={16} />
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Project count */}
        <div className="text-center mt-12">
          <p className="text-gray-500 dark:text-gray-400 text-sm">
            Showing <span className="font-semibold text-gray-700 dark:text-gray-300">{filteredProjects.length}</span> of{' '}
            <span className="font-semibold text-gray-700 dark:text-gray-300">{projectsData.length}</span> projects
          </p>
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
