import { useState } from 'react';
import { X, Github, Play, Apple, ExternalLink, Share2, ChevronLeft, ChevronRight } from 'lucide-react';

interface ProjectModalProps {
  project: any;
  onClose: () => void;
}

export function ProjectModal({ project, onClose }: ProjectModalProps) {
  const images: string[] = project.images && project.images.length > 0 ? project.images : [project.image];
  const [activeIndex, setActiveIndex] = useState(0);
  const activeImage = images[activeIndex];

  const prev = () => setActiveIndex((i) => (i - 1 + images.length) % images.length);
  const next = () => setActiveIndex((i) => (i + 1) % images.length);

  const handleShare = async () => {
    const url = project.store || project.appStore || project.github || project.live || window.location.href;
    try {
      if (navigator.share) {
        await navigator.share({ title: project.title, text: project.description, url });
      } else {
        await navigator.clipboard.writeText(url);
        alert('Link copied to clipboard!');
      }
    } catch (err) {
      console.error('Error sharing:', err);
    }
  };

  return (
    <div
      className="fixed inset-0 z-50 flex items-start justify-center overflow-y-auto bg-black/70 backdrop-blur-md p-0 sm:p-6"
      onClick={(e) => { if (e.target === e.currentTarget) onClose(); }}
    >
      <div className="bg-white dark:bg-gray-950 w-full max-w-5xl sm:rounded-2xl shadow-2xl border border-transparent dark:border-gray-800 sm:my-8 flex flex-col overflow-hidden">

        {/* ── Top bar ── */}
        <div className="flex items-center justify-between px-5 py-4 border-b border-gray-100 dark:border-gray-800 shrink-0">
          <div className="flex items-center gap-3">
            <span className="px-3 py-1 bg-blue-600/10 dark:bg-blue-500/20 text-blue-600 dark:text-blue-400 rounded-full text-xs font-semibold uppercase tracking-wide">
              {project.category}
            </span>
            <h2 className="text-lg sm:text-2xl font-bold text-gray-900 dark:text-white truncate">
              {project.title}
            </h2>
          </div>
          <div className="flex items-center gap-2 shrink-0">
            <button
              onClick={handleShare}
              className="p-2 rounded-xl text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
              title="Share"
            >
              <Share2 size={18} />
            </button>
            <button
              onClick={onClose}
              className="p-2 rounded-xl text-gray-500 dark:text-gray-400 hover:bg-red-50 dark:hover:bg-red-900/20 hover:text-red-500 transition-colors"
              aria-label="Close"
            >
              <X size={20} />
            </button>
          </div>
        </div>

        {/* ── Image gallery section ── */}
        <div className="flex flex-col md:flex-row gap-0 md:gap-4 bg-gray-950 p-3 sm:p-4 shrink-0">
          {/* Thumbnail strip — left on desktop, bottom on mobile */}
          {images.length > 1 && (
            <div className="flex md:flex-col gap-2 overflow-x-auto md:overflow-y-auto md:overflow-x-visible pb-2 md:pb-0 md:pr-2 order-2 md:order-1 shrink-0"
              style={{ maxHeight: '480px' }}
            >
              {images.map((img, idx) => (
                <button
                  key={idx}
                  onClick={() => setActiveIndex(idx)}
                  className={`flex-shrink-0 w-14 h-20 sm:w-16 sm:h-24 rounded-lg overflow-hidden border-2 transition-all duration-200 ${
                    activeIndex === idx
                      ? 'border-blue-500 ring-2 ring-blue-500/30 opacity-100'
                      : 'border-transparent opacity-40 hover:opacity-75'
                  }`}
                >
                  <img
                    src={img}
                    alt={`Screen ${idx + 1}`}
                    className="w-full h-full object-cover bg-gray-900"
                    loading="lazy"
                  />
                </button>
              ))}
            </div>
          )}

          {/* Main image viewer */}
          <div className="relative flex-1 flex items-center justify-center order-1 md:order-2 bg-gray-900 rounded-xl overflow-hidden" style={{ minHeight: '320px', maxHeight: '520px' }}>
            <img
              key={activeImage}
              src={activeImage}
              alt={project.title}
              className="max-w-full max-h-full object-contain transition-all duration-300"
              style={{ maxHeight: '516px' }}
              onError={(e) => {
                const t = e.target as HTMLImageElement;
                t.style.display = 'none';
              }}
            />

            {/* Prev / Next arrows */}
            {images.length > 1 && (
              <>
                <button
                  onClick={prev}
                  className="absolute left-2 top-1/2 -translate-y-1/2 p-2 bg-black/50 hover:bg-black/80 text-white rounded-full backdrop-blur-sm transition-all"
                >
                  <ChevronLeft size={20} />
                </button>
                <button
                  onClick={next}
                  className="absolute right-2 top-1/2 -translate-y-1/2 p-2 bg-black/50 hover:bg-black/80 text-white rounded-full backdrop-blur-sm transition-all"
                >
                  <ChevronRight size={20} />
                </button>

                {/* Dot indicator */}
                <div className="absolute bottom-3 left-1/2 -translate-x-1/2 flex gap-1.5">
                  {images.map((_, idx) => (
                    <button
                      key={idx}
                      onClick={() => setActiveIndex(idx)}
                      className={`rounded-full transition-all duration-200 ${
                        activeIndex === idx ? 'w-4 h-2 bg-blue-500' : 'w-2 h-2 bg-white/40 hover:bg-white/70'
                      }`}
                    />
                  ))}
                </div>
              </>
            )}

            {/* Count badge */}
            {images.length > 1 && (
              <div className="absolute top-3 right-3 bg-black/60 backdrop-blur-sm text-white text-xs px-2.5 py-1 rounded-full font-medium">
                {activeIndex + 1} / {images.length}
              </div>
            )}
          </div>
        </div>

        {/* ── Content body ── */}
        <div className="p-5 sm:p-8 flex-grow">
          <p className="text-base sm:text-lg text-gray-700 dark:text-gray-300 mb-8 leading-relaxed font-light">
            {project.detailedDescription}
          </p>

          <div className="grid md:grid-cols-2 gap-8 mb-8">
            {/* Features */}
            <div className="space-y-3">
              <h3 className="text-base sm:text-lg font-bold text-gray-900 dark:text-white flex items-center gap-2">
                <span className="w-7 h-7 bg-blue-100 dark:bg-blue-900/40 text-blue-600 dark:text-blue-400 rounded-lg flex items-center justify-center">
                  <Play size={13} fill="currentColor" />
                </span>
                Highlights
              </h3>
              <ul className="space-y-2.5 pl-1">
                {project.features.map((feature: string, idx: number) => (
                  <li key={idx} className="flex items-start gap-3">
                    <span className="mt-2 w-1.5 h-1.5 rounded-full bg-blue-500 shrink-0"></span>
                    <span className="text-gray-600 dark:text-gray-400 text-sm leading-snug">{feature}</span>
                  </li>
                ))}
              </ul>
            </div>

            {/* Technologies */}
            <div className="space-y-3">
              <h3 className="text-base sm:text-lg font-bold text-gray-900 dark:text-white flex items-center gap-2">
                <span className="w-7 h-7 bg-indigo-100 dark:bg-indigo-900/40 text-indigo-600 dark:text-indigo-400 rounded-lg flex items-center justify-center text-xs font-bold">
                  {'</>'}
                </span>
                Tech Stack
              </h3>
              <div className="flex flex-wrap gap-2">
                {project.technologies.map((tech: string, idx: number) => (
                  <span
                    key={idx}
                    className="px-3 py-1.5 bg-gray-50 dark:bg-gray-900 text-gray-700 dark:text-gray-300 rounded-lg border border-gray-200 dark:border-gray-800 text-xs font-medium hover:border-blue-500/50 hover:bg-blue-500/5 transition-colors"
                  >
                    {tech}
                  </span>
                ))}
              </div>
            </div>
          </div>

          {/* Links */}
          <div className="flex flex-col sm:flex-row flex-wrap gap-3 pt-6 border-t border-gray-100 dark:border-gray-800">
            {project.github && (
              <a href={project.github} target="_blank" rel="noopener noreferrer"
                className="flex items-center justify-center gap-2 px-6 py-3 bg-gray-900 dark:bg-white dark:text-gray-900 text-white rounded-xl hover:bg-gray-700 dark:hover:bg-gray-100 transition-all shadow-md font-semibold text-sm"
              >
                <Github size={18} /> Source Code
              </a>
            )}
            {project.store && (
              <a href={project.store} target="_blank" rel="noopener noreferrer"
                className="flex items-center justify-center gap-2 px-6 py-3 bg-green-600 text-white rounded-xl hover:bg-green-700 transition-all shadow-md font-semibold text-sm"
              >
                <Play size={18} /> Play Store
              </a>
            )}
            {project.appStore && (
              <a href={project.appStore} target="_blank" rel="noopener noreferrer"
                className="flex items-center justify-center gap-2 px-6 py-3 bg-blue-600 text-white rounded-xl hover:bg-blue-700 transition-all shadow-md font-semibold text-sm"
              >
                <Apple size={18} /> App Store
              </a>
            )}
            {project.live && (
              <a href={project.live} target="_blank" rel="noopener noreferrer"
                className="flex items-center justify-center gap-2 px-6 py-3 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-xl hover:scale-105 transition-all shadow-md font-semibold text-sm"
              >
                <ExternalLink size={18} /> Live Preview
              </a>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}