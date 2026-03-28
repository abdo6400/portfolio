import { useState, useRef } from 'react';
import { X, Github, Play, Apple, ExternalLink, Share2, ChevronLeft, ChevronRight } from 'lucide-react';

interface ProjectModalProps {
  project: any;
  onClose: () => void;
}

export function ProjectModal({ project, onClose }: ProjectModalProps) {
  const images: string[] = project.images && project.images.length > 0 ? project.images : [project.image];
  const [activeIndex, setActiveIndex] = useState(0);
  const touchStartX = useRef<number>(0);
  const touchEndX = useRef<number>(0);

  const prev = () => setActiveIndex((i) => (i - 1 + images.length) % images.length);
  const next = () => setActiveIndex((i) => (i + 1) % images.length);

  const onTouchStart = (e: React.TouchEvent) => { touchStartX.current = e.touches[0].clientX; };
  const onTouchEnd = (e: React.TouchEvent) => {
    touchEndX.current = e.changedTouches[0].clientX;
    const diff = touchStartX.current - touchEndX.current;
    if (Math.abs(diff) > 50) diff > 0 ? next() : prev();
  };

  const handleShare = async () => {
    const url = project.store || project.appStore || project.github || project.live || window.location.href;
    try {
      if (navigator.share) {
        await navigator.share({ title: project.title, text: project.description, url });
      } else {
        await navigator.clipboard.writeText(url);
        alert('Link copied!');
      }
    } catch (err) { console.error(err); }
  };

  return (
    <div
      className="fixed inset-0 z-50 flex items-start justify-center overflow-y-auto bg-black/70 backdrop-blur-md p-0 sm:p-6"
      onClick={(e) => { if (e.target === e.currentTarget) onClose(); }}
    >
      <div className="bg-white dark:bg-gray-950 w-full max-w-5xl sm:rounded-2xl shadow-2xl border border-transparent dark:border-gray-800 sm:my-8 flex flex-col overflow-hidden">

        {/* ── Top bar ── */}
        <div className="flex items-center justify-between px-5 py-4 border-b border-gray-100 dark:border-gray-800 shrink-0">
          <div className="flex items-center gap-3 min-w-0">
            <span className="shrink-0 px-3 py-1 bg-blue-600/10 dark:bg-blue-500/20 text-blue-600 dark:text-blue-400 rounded-full text-xs font-semibold uppercase tracking-wide">
              {project.category}
            </span>
            <h2 className="text-lg sm:text-2xl font-bold text-gray-900 dark:text-white truncate">
              {project.title}
            </h2>
          </div>
          <div className="flex items-center gap-2 shrink-0 ml-3">
            <button onClick={handleShare} className="p-2 rounded-xl text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors" title="Share">
              <Share2 size={18} />
            </button>
            <button onClick={onClose} className="p-2 rounded-xl text-gray-500 dark:text-gray-400 hover:bg-red-50 dark:hover:bg-red-900/20 hover:text-red-500 transition-colors" aria-label="Close">
              <X size={20} />
            </button>
          </div>
        </div>

        {/* ── Carousel ── */}
        <div className="relative bg-gray-950 overflow-hidden select-none shrink-0" style={{ height: '480px' }}
          onTouchStart={onTouchStart}
          onTouchEnd={onTouchEnd}
        >
          {/* Sliding track */}
          <div
            className="flex h-full transition-transform duration-500 ease-in-out"
            style={{ transform: `translateX(-${activeIndex * 100}%)`, width: `${images.length * 100}%` }}
          >
            {images.map((img, idx) => (
              <div
                key={idx}
                className="flex items-center justify-center h-full flex-shrink-0"
                style={{ width: `${100 / images.length}%` }}
              >
                {img.endsWith('.mp4') ? (
                  <video
                    src={img}
                    className="max-h-full max-w-full"
                    controls
                    playsInline
                    style={{ maxHeight: '476px' }}
                  />
                ) : (
                  <img
                    src={img}
                    alt={`${project.title} - ${idx + 1}`}
                    className="max-h-full max-w-full object-contain"
                    draggable={false}
                    loading={idx === 0 ? 'eager' : 'lazy'}
                  />
                )}
              </div>
            ))}
          </div>

          {/* Prev / Next arrows */}
          {images.length > 1 && (
            <>
              <button
                onClick={prev}
                className="absolute left-3 top-1/2 -translate-y-1/2 z-10 p-2.5 bg-black/50 hover:bg-black/80 text-white rounded-full backdrop-blur-sm transition-all hover:scale-110 shadow-lg"
              >
                <ChevronLeft size={22} />
              </button>
              <button
                onClick={next}
                className="absolute right-3 top-1/2 -translate-y-1/2 z-10 p-2.5 bg-black/50 hover:bg-black/80 text-white rounded-full backdrop-blur-sm transition-all hover:scale-110 shadow-lg"
              >
                <ChevronRight size={22} />
              </button>
            </>
          )}

          {/* Counter badge */}
          {images.length > 1 && (
            <div className="absolute top-3 right-3 z-10 bg-black/60 backdrop-blur-sm text-white text-xs px-2.5 py-1 rounded-full font-medium">
              {activeIndex + 1} / {images.length}
            </div>
          )}

          {/* Dot indicators */}
          {images.length > 1 && (
            <div className="absolute bottom-4 left-1/2 -translate-x-1/2 z-10 flex items-center gap-1.5">
              {images.map((_, idx) => (
                <button
                  key={idx}
                  onClick={() => setActiveIndex(idx)}
                  className={`rounded-full transition-all duration-300 ${
                    activeIndex === idx
                      ? 'w-5 h-2 bg-blue-500'
                      : 'w-2 h-2 bg-white/35 hover:bg-white/60'
                  }`}
                />
              ))}
            </div>
          )}

          {/* Swipe hint (hidden after first interaction) */}
          {images.length > 1 && activeIndex === 0 && (
            <div className="absolute bottom-10 left-1/2 -translate-x-1/2 z-10 text-white/40 text-xs pointer-events-none hidden sm:flex items-center gap-1">
              <ChevronLeft size={12} /> swipe or use arrows <ChevronRight size={12} />
            </div>
          )}
        </div>

        {/* ── Thumbnail strip ── */}
        {images.length > 1 && (
          <div className="flex gap-2 overflow-x-auto bg-gray-900 px-4 py-3 scrollbar-thin scrollbar-thumb-gray-700">
            {images.map((img, idx) => (
              <button
                key={idx}
                onClick={() => setActiveIndex(idx)}
                className={`flex-shrink-0 rounded-lg overflow-hidden border-2 transition-all duration-200 ${
                  activeIndex === idx
                    ? 'border-blue-500 ring-2 ring-blue-500/30 opacity-100 scale-105'
                    : 'border-transparent opacity-40 hover:opacity-70'
                }`}
                style={{ width: 48, height: 72 }}
              >
                {img.endsWith('.mp4') ? (
                  <div className="w-full h-full bg-gray-800 flex items-center justify-center">
                    <svg className="w-5 h-5 text-blue-400" fill="currentColor" viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg>
                  </div>
                ) : (
                  <img src={img} alt={`thumb ${idx + 1}`} className="w-full h-full object-cover" loading="lazy" />
                )}
              </button>
            ))}
          </div>
        )}

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