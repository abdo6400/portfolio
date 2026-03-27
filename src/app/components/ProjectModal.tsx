import { X, Github, Play, Apple, ExternalLink, Share2 } from 'lucide-react';

interface ProjectModalProps {
  project: any;
  onClose: () => void;
}

export function ProjectModal({ project, onClose }: ProjectModalProps) {
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
    <div className="fixed inset-0 bg-black/50 dark:bg-black/70 z-50 flex items-center justify-center p-4 overflow-y-auto backdrop-blur-sm">
      <div className="bg-white dark:bg-gray-950 rounded-2xl max-w-4xl w-full my-8 shadow-2xl border border-transparent dark:border-gray-800">
        {/* Header */}
        <div className="relative h-48 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-t-2xl overflow-hidden">
          <div className="absolute inset-0 flex items-center justify-center">
            <div className="text-white text-8xl opacity-20">
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
            className="absolute top-4 right-4 p-2 bg-white/20 backdrop-blur-sm text-white rounded-full hover:bg-white/30 transition-colors"
          >
            <X size={24} />
          </button>
          <div className="absolute bottom-4 left-6">
            <span className="bg-white/20 backdrop-blur-sm text-white px-4 py-2 rounded-full">
              {project.category}
            </span>
          </div>
        </div>

        {/* Content */}
        <div className="p-8">
          <h2 className="text-3xl text-gray-900 dark:text-white mb-4">{project.title}</h2>
          
          <p className="text-lg text-gray-700 dark:text-gray-300 mb-6">
            {project.detailedDescription}
          </p>

          {/* Features */}
          <div className="mb-6">
            <h3 className="text-xl text-gray-900 dark:text-white mb-3">Key Features</h3>
            <ul className="space-y-2">
              {project.features.map((feature: string, idx: number) => (
                <li key={idx} className="flex items-start gap-2">
                  <span className="text-blue-600 dark:text-blue-400 mt-1">✓</span>
                  <span className="text-gray-700 dark:text-gray-300">{feature}</span>
                </li>
              ))}
            </ul>
          </div>

          {/* Technologies */}
          <div className="mb-6">
            <h3 className="text-xl text-gray-900 dark:text-white mb-3">Technologies</h3>
            <div className="flex flex-wrap gap-2">
              {project.technologies.map((tech: string, idx: number) => (
                <span
                  key={idx}
                  className="px-4 py-2 bg-blue-50 dark:bg-blue-950 text-blue-600 dark:text-blue-400 rounded-lg border border-blue-100 dark:border-blue-900"
                >
                  {tech}
                </span>
              ))}
            </div>
          </div>

          {/* Links */}
          <div className="flex flex-wrap gap-3">
            {project.github && (
              <a
                href={project.github}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center gap-2 px-6 py-3 bg-gray-900 dark:bg-gray-800 text-white rounded-lg hover:bg-gray-800 dark:hover:bg-gray-700 transition-all hover:scale-105"
              >
                <Github size={20} />
                <span>View on GitHub</span>
              </a>
            )}
            {project.store && (
              <a
                href={project.store}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center gap-2 px-6 py-3 bg-green-600 dark:bg-green-700 text-white rounded-lg hover:bg-green-700 dark:hover:bg-green-600 transition-all hover:scale-105"
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
                className="flex items-center gap-2 px-6 py-3 bg-gray-900 dark:bg-gray-800 text-white rounded-lg hover:bg-gray-800 dark:hover:bg-gray-700 transition-all hover:scale-105"
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
                className="flex items-center gap-2 px-6 py-3 bg-blue-600 dark:bg-blue-700 text-white rounded-lg hover:bg-blue-700 dark:hover:bg-blue-600 transition-all hover:scale-105"
              >
                <ExternalLink size={20} />
                <span>Live Demo</span>
              </a>
            )}
            <button
              onClick={handleShare}
              className="flex items-center gap-2 px-6 py-3 bg-purple-600 dark:bg-purple-700 text-white rounded-lg hover:bg-purple-700 dark:hover:bg-purple-600 transition-all hover:scale-105"
            >
              <Share2 size={20} />
              <span>Share Project</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}