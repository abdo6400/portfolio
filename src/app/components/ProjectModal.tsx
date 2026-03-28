import { useState } from 'react';
import { X, Github, Play, Apple, ExternalLink, Share2 } from 'lucide-react';

interface ProjectModalProps {
  project: any;
  onClose: () => void;
}

export function ProjectModal({ project, onClose }: ProjectModalProps) {
  const [activeImage, setActiveImage] = useState(project.image);

  const handleShare = async () => {
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
    <div className="fixed inset-0 bg-black/60 dark:bg-black/80 z-50 flex items-start justify-center p-0 sm:p-4 overflow-y-auto backdrop-blur-md transition-all duration-300">
      <div className="bg-white dark:bg-gray-950 rounded-none sm:rounded-2xl max-w-4xl w-full sm:my-8 shadow-2xl border-x-0 sm:border border-transparent dark:border-gray-800 flex flex-col min-h-screen sm:min-h-0 animate-in fade-in zoom-in duration-200">
        {/* Header / Main Image */}
        <div className="relative w-full aspect-video sm:h-80 md:h-96 overflow-hidden rounded-t-none sm:rounded-t-2xl group shrink-0">
          <img 
            src={activeImage} 
            alt={project.title}
            className="w-full h-full object-cover transition-all duration-700 hover:scale-105"
            onError={(e) => {
              const target = e.target as HTMLImageElement;
              target.style.display = 'none';
              target.nextElementSibling?.classList.remove('hidden');
            }}
          />
          <div className="hidden absolute inset-0 bg-gradient-to-br from-blue-600 to-indigo-700 flex items-center justify-center">
            <div className="text-white text-6xl md:text-8xl opacity-30">
              {project.category === 'Financial' && '💰'}
              {project.category === 'E-commerce' && '🛒'}
              {project.category === 'Real Estate' && '🏠'}
              {project.category === 'News Application' && '📰'}
              {project.category === 'AI' && '🤖'}
              {project.category === 'Services' && '🔧'}
              {project.category === 'Charity' && '❤️'}
            </div>
          </div>
          
          <button
            onClick={onClose}
            className="absolute top-4 right-4 p-3 bg-black/40 backdrop-blur-xl text-white rounded-full hover:bg-black/60 transition-all z-20 shadow-lg border border-white/10"
            aria-label="Close modal"
          >
            <X size={24} />
          </button>

          <div className="absolute bottom-4 left-4 sm:left-6 z-10">
            <span className="bg-blue-600/90 backdrop-blur-md text-white px-4 py-1.5 rounded-full text-xs sm:text-sm font-semibold shadow-xl border border-white/10">
              {project.category}
            </span>
          </div>
          
          <div className="absolute inset-x-0 bottom-0 h-24 bg-gradient-to-t from-black/60 to-transparent opacity-60 sm:hidden"></div>
        </div>

        {/* Content */}
        <div className="p-5 sm:p-8 md:p-10 flex-grow">
          <div className="flex flex-col sm:flex-row sm:justify-between sm:items-start gap-4 mb-6">
            <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold text-gray-900 dark:text-white leading-tight">
              {project.title}
            </h2>
            <div className="flex items-center gap-3 self-end sm:self-start">
              <button
                onClick={handleShare}
                className="p-2.5 bg-gray-50 dark:bg-gray-900 text-gray-600 dark:text-gray-400 rounded-xl hover:bg-blue-600 hover:text-white dark:hover:bg-blue-600 transition-all border border-gray-200 dark:border-gray-800 shadow-sm"
                title="Share Project"
              >
                <Share2 size={20} />
              </button>
            </div>
          </div>
          
          <p className="text-base sm:text-lg text-gray-700 dark:text-gray-300 mb-8 leading-relaxed font-light">
            {project.detailedDescription}
          </p>

          <div className="grid md:grid-cols-2 gap-8 mb-10">
            {/* Features */}
            <div className="space-y-4">
              <h3 className="text-lg sm:text-xl font-bold text-gray-900 dark:text-white flex items-center gap-3">
                <span className="w-9 h-9 bg-blue-100 dark:bg-blue-900/40 text-blue-600 dark:text-blue-400 rounded-xl flex items-center justify-center text-sm shadow-inner">
                  <Play size={16} fill="currentColor" />
                </span>
                Featured Highlights
              </h3>
              <ul className="space-y-3 pl-1">
                {project.features.map((feature: string, idx: number) => (
                  <li key={idx} className="flex items-start gap-3 group">
                    <span className="text-blue-500 mt-1.5 w-1.5 h-1.5 rounded-full bg-blue-500 group-hover:scale-125 transition-transform shrink-0"></span>
                    <span className="text-gray-600 dark:text-gray-400 text-sm sm:text-base leading-snug">{feature}</span>
                  </li>
                ))}
              </ul>
            </div>

            {/* Technologies */}
            <div className="space-y-4">
              <h3 className="text-lg sm:text-xl font-bold text-gray-900 dark:text-white flex items-center gap-3">
                <span className="w-9 h-9 bg-indigo-100 dark:bg-indigo-900/40 text-indigo-600 dark:text-indigo-400 rounded-xl flex items-center justify-center text-sm shadow-inner">
                  <div className="w-4 h-4 border-2 border-indigo-600 dark:border-indigo-400 rounded-full border-t-transparent animate-spin-slow"></div>
                </span>
                Core Stack
              </h3>
              <div className="flex flex-wrap gap-2 pt-1">
                {project.technologies.map((tech: string, idx: number) => (
                  <span
                    key={idx}
                    className="px-4 py-2 bg-gray-50 dark:bg-gray-900 text-gray-700 dark:text-gray-300 rounded-xl border border-gray-200 dark:border-gray-800 text-xs sm:text-sm font-medium hover:border-blue-500/50 hover:bg-blue-500/5 transition-colors"
                  >
                    {tech}
                  </span>
                ))}
              </div>
            </div>
          </div>

          {/* Gallery */}
          {project.images && project.images.length > 1 && (
            <div className="mb-10 animate-in slide-in-from-bottom-4 duration-500 delay-200">
              <h3 className="text-lg sm:text-xl font-bold text-gray-900 dark:text-white mb-5">Visual Tour</h3>
              <div className="flex gap-4 overflow-x-auto pb-4 pt-1 px-1 -mx-1 scrollbar-thin scrollbar-thumb-gray-300 dark:scrollbar-thumb-gray-800">
                {project.images.map((img: string, idx: number) => (
                  <button
                    key={idx}
                    onClick={() => setActiveImage(img)}
                    className={`relative flex-shrink-0 w-32 h-20 sm:w-40 sm:h-24 rounded-xl overflow-hidden border-2 transition-all duration-300 active:scale-95 ${
                      activeImage === img 
                        ? 'border-blue-600 scale-105 shadow-xl ring-4 ring-blue-500/20' 
                        : 'border-transparent opacity-60 hover:opacity-100 grayscale hover:grayscale-0'
                    }`}
                  >
                    <img src={img} alt={`Screenshot ${idx + 1}`} className="w-full h-full object-cover" loading="lazy" />
                  </button>
                ))}
              </div>
            </div>
          )}

          {/* Links */}
          <div className="flex flex-col sm:flex-row flex-wrap gap-4 pt-8 border-t border-gray-100 dark:border-gray-800 mt-auto">
            {project.github && (
              <a
                href={project.github}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center justify-center gap-3 px-8 py-3.5 bg-gray-900 dark:bg-white dark:text-gray-900 text-white rounded-xl hover:bg-gray-800 dark:hover:bg-gray-100 transition-all shadow-lg hover:shadow-gray-900/25 font-semibold text-base"
              >
                <Github size={20} />
                <span>Source Code</span>
              </a>
            )}
            {project.store && (
              <a
                href={project.store}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center justify-center gap-3 px-8 py-3.5 bg-green-600 text-white rounded-xl hover:bg-green-700 transition-all shadow-lg hover:shadow-green-900/25 font-semibold text-base"
              >
                <Play size={20} />
                <span>Play Store</span>
              </a>
            )}
            {project.appStore && (
              <a
                href={project.appStore}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center justify-center gap-3 px-8 py-3.5 bg-blue-600 text-white rounded-xl hover:bg-blue-700 transition-all shadow-lg hover:shadow-blue-900/25 font-semibold text-base"
              >
                <Apple size={20} />
                <span>App Store</span>
              </a>
            )}
            {project.live && (
              <a
                href={project.live}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center justify-center gap-3 px-8 py-3.5 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-xl hover:scale-105 transition-all shadow-xl hover:shadow-blue-900/25 font-semibold text-base group"
              >
                <ExternalLink size={20} className="group-hover:translate-x-0.5 group-hover:-translate-y-0.5 transition-transform" />
                <span>Live Preview</span>
              </a>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}