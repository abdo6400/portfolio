import { useState, useRef, useEffect, useCallback } from 'react';
import { X, Github, Play, Apple, ExternalLink, Share2, ChevronLeft, ChevronRight, ZoomIn, ZoomOut, Maximize2, Minimize2, MessageCircle } from 'lucide-react';

interface ProjectModalProps {
  project: any;
  onClose: () => void;
}

export function ProjectModal({ project, onClose }: ProjectModalProps) {
  const images: string[] = project.images && project.images.length > 0 ? project.images : [project.image];
  const [activeIndex, setActiveIndex] = useState(0);
  const [isZoomed, setIsZoomed] = useState(false);
  const [isFullscreen, setIsFullscreen] = useState(false);
  const [imageLoaded, setImageLoaded] = useState<Record<number, boolean>>({});
  const [imageError, setImageError] = useState<Record<number, boolean>>({});
  const touchStartX = useRef<number>(0);
  const touchEndX = useRef<number>(0);
  const modalRef = useRef<HTMLDivElement>(null);
  const imageContainerRef = useRef<HTMLDivElement>(null);

  const prev = useCallback(() => {
    setActiveIndex((i) => (i - 1 + images.length) % images.length);
    setIsZoomed(false);
  }, [images.length]);

  const next = useCallback(() => {
    setActiveIndex((i) => (i + 1) % images.length);
    setIsZoomed(false);
  }, [images.length]);

  // Keyboard navigation
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        if (isFullscreen) {
          setIsFullscreen(false);
        } else if (isZoomed) {
          setIsZoomed(false);
        } else {
          onClose();
        }
      } else if (e.key === 'ArrowLeft') {
        prev();
      } else if (e.key === 'ArrowRight') {
        next();
      } else if (e.key === 'f' || e.key === 'F') {
        setIsFullscreen((prev) => !prev);
      } else if (e.key === 'z' || e.key === 'Z') {
        setIsZoomed((prev) => !prev);
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [onClose, prev, next, isFullscreen, isZoomed]);

  // Prevent body scroll when modal is open
  useEffect(() => {
    document.body.style.overflow = 'hidden';
    return () => {
      document.body.style.overflow = '';
    };
  }, []);

  const onTouchStart = (e: React.TouchEvent) => {
    touchStartX.current = e.touches[0].clientX;
  };

  const onTouchEnd = (e: React.TouchEvent) => {
    touchEndX.current = e.changedTouches[0].clientX;
    const diff = touchStartX.current - touchEndX.current;
    if (Math.abs(diff) > 50) {
      diff > 0 ? next() : prev();
    }
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
    } catch (err) {
      console.error(err);
    }
  };

  const handleWhatsAppOrder = () => {
    const phoneNumber = '201069645711'; // WhatsApp number
    const message = encodeURIComponent(
      `Hello! I'm interested in ordering a project similar to: ${project.title}\n\nProject Description: ${project.description}\n\nPlease provide more details about pricing and timeline.`
    );
    const whatsappUrl = `https://wa.me/${phoneNumber}?text=${message}`;
    window.open(whatsappUrl, '_blank');
  };

  const toggleZoom = () => {
    setIsZoomed((prev) => !prev);
  };

  const toggleFullscreen = () => {
    setIsFullscreen((prev) => !prev);
    if (!isFullscreen) {
      setIsZoomed(false);
    }
  };

  const handleImageLoad = (index: number) => {
    setImageLoaded((prev) => ({ ...prev, [index]: true }));
  };

  const handleImageError = (index: number) => {
    setImageError((prev) => ({ ...prev, [index]: true }));
  };

  // Preload adjacent images and videos
  useEffect(() => {
    const preloadIndexes = [
      (activeIndex - 1 + images.length) % images.length,
      (activeIndex + 1) % images.length,
    ];

    preloadIndexes.forEach((index) => {
      if (images[index]) {
        if (images[index].endsWith('.mp4')) {
          // For videos, we can't preload them easily, but we can ensure they're ready
          const video = document.createElement('video');
          video.preload = 'metadata';
          video.src = images[index];
        } else {
          const img = new Image();
          img.src = images[index];
        }
      }
    });
  }, [activeIndex, images]);

  return (
    <div
      ref={modalRef}
      className={`fixed inset-0 z-[60] flex items-start justify-center overflow-y-auto bg-black/80 backdrop-blur-lg transition-all duration-300 ${isFullscreen ? 'pt-16' : 'p-0 sm:p-6'
        }`}
      onClick={(e) => {
        if (e.target === e.currentTarget) onClose();
      }}
    >
      <div
        className={`bg-white dark:bg-gray-950 w-full shadow-2xl border border-transparent dark:border-gray-800 flex flex-col overflow-hidden transition-all duration-300 ${isFullscreen
          ? 'max-w-full h-[calc(100vh-64px)] sm:rounded-none my-0'
          : 'max-w-5xl sm:rounded-2xl sm:my-8'
          }`}
      >
        {/* ── Top bar ── */}
        <div className="flex items-center justify-between px-5 py-4 border-b border-gray-100 dark:border-gray-800 shrink-0 bg-white/80 dark:bg-gray-950/80 backdrop-blur-sm sticky top-0 z-20">
          <div className="flex items-center gap-3 min-w-0">
            <span className="shrink-0 px-3 py-1.5 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-full text-xs font-bold uppercase tracking-wider shadow-lg shadow-blue-500/20">
              {project.category}
            </span>
            <h2 className="text-lg sm:text-2xl font-bold text-gray-900 dark:text-white truncate">
              {project.title}
            </h2>
          </div>
          <div className="flex items-center gap-2 shrink-0 ml-3">
            <button
              onClick={toggleFullscreen}
              className="p-2.5 rounded-xl text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 transition-all hover:scale-110"
              title={isFullscreen ? 'Exit fullscreen (F)' : 'Fullscreen (F)'}
            >
              {isFullscreen ? <Minimize2 size={18} /> : <Maximize2 size={18} />}
            </button>
            <button
              onClick={handleShare}
              className="p-2.5 rounded-xl text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 transition-all hover:scale-110"
              title="Share"
            >
              <Share2 size={18} />
            </button>
            <button
              onClick={onClose}
              className="p-2.5 rounded-xl text-gray-500 dark:text-gray-400 hover:bg-red-50 dark:hover:bg-red-900/20 hover:text-red-500 transition-all hover:scale-110"
              aria-label="Close (Esc)"
            >
              <X size={20} />
            </button>
          </div>
        </div>

        {/* ── Carousel ── */}
        <div
          ref={imageContainerRef}
          className={`relative bg-gradient-to-br from-gray-900 to-gray-950 overflow-hidden select-none shrink-0 transition-all duration-300 ${isFullscreen ? 'flex-1' : ''
            }`}
          style={{ height: isFullscreen ? 'calc(100vh - 64px)' : '480px' }}
          onTouchStart={onTouchStart}
          onTouchEnd={onTouchEnd}
        >
          {/* Sliding track */}
          <div
            className="flex h-full transition-transform duration-500 ease-out"
            style={{ transform: `translateX(-${activeIndex * (100 / images.length)}%)`, width: `${images.length * 100}%` }}
          >
            {images.map((img, idx) => (
              <div
                key={idx}
                className="flex items-center justify-center h-full flex-shrink-0 relative"
                style={{ width: `${100 / images.length}%` }}
              >
                {/* Loading skeleton */}
                {!imageLoaded[idx] && !imageError[idx] && (
                  <div className="absolute inset-0 flex items-center justify-center bg-gray-800">
                    <div className="flex flex-col items-center gap-3">
                      <div className="w-12 h-12 border-4 border-blue-500/30 border-t-blue-500 rounded-full animate-spin"></div>
                      <span className="text-gray-400 text-sm">Loading...</span>
                    </div>
                  </div>
                )}

                {/* Error state */}
                {imageError[idx] && (
                  <div className="absolute inset-0 flex items-center justify-center bg-gray-800">
                    <div className="flex flex-col items-center gap-3 text-gray-400">
                      <div className="w-16 h-16 rounded-full bg-gray-700 flex items-center justify-center">
                        <X size={24} />
                      </div>
                      <span className="text-sm">Failed to load image</span>
                    </div>
                  </div>
                )}

                {img.endsWith('.mp4') ? (
                  <video
                    key={`video-${idx}-${activeIndex}`}
                    src={img}
                    className={`max-h-full max-w-full transition-transform duration-300 ${isZoomed ? 'scale-150 cursor-zoom-out' : 'cursor-zoom-in'
                      }`}
                    controls
                    playsInline
                    preload={activeIndex === idx ? 'auto' : 'metadata'}
                    style={{ maxHeight: isFullscreen ? '100%' : '476px', maxWidth: '100%' }}
                    onLoadedData={() => handleImageLoad(idx)}
                    onError={() => handleImageError(idx)}
                  />
                ) : (
                  <img
                    src={img}
                    alt={`${project.title} - ${idx + 1}`}
                    className={`max-h-full max-w-full object-contain transition-all duration-300 ${isZoomed ? 'scale-150 cursor-zoom-out' : 'cursor-zoom-in'
                      }`}
                    draggable={false}
                    loading={idx === 0 ? 'eager' : 'lazy'}
                    onLoad={() => handleImageLoad(idx)}
                    onError={() => handleImageError(idx)}
                    onClick={activeIndex === idx ? toggleZoom : undefined}
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
                className="absolute left-3 top-1/2 -translate-y-1/2 z-10 p-3 bg-black/50 hover:bg-black/80 text-white rounded-full backdrop-blur-sm transition-all hover:scale-110 shadow-xl hover:shadow-2xl group"
                title="Previous (←)"
              >
                <ChevronLeft size={24} className="group-hover:-translate-x-0.5 transition-transform" />
              </button>
              <button
                onClick={next}
                className="absolute right-3 top-1/2 -translate-y-1/2 z-10 p-3 bg-black/50 hover:bg-black/80 text-white rounded-full backdrop-blur-sm transition-all hover:scale-110 shadow-xl hover:shadow-2xl group"
                title="Next (→)"
              >
                <ChevronRight size={24} className="group-hover:translate-x-0.5 transition-transform" />
              </button>
            </>
          )}

          {/* Zoom button */}
          {!images[activeIndex]?.endsWith('.mp4') && (
            <button
              onClick={toggleZoom}
              className="absolute top-3 left-3 z-10 p-2.5 bg-black/50 hover:bg-black/80 text-white rounded-full backdrop-blur-sm transition-all hover:scale-110 shadow-lg"
              title={isZoomed ? 'Zoom out (Z)' : 'Zoom in (Z)'}
            >
              {isZoomed ? <ZoomOut size={18} /> : <ZoomIn size={18} />}
            </button>
          )}

          {/* Counter badge */}
          {images.length > 1 && (
            <div className="absolute top-3 right-3 z-10 bg-black/60 backdrop-blur-sm text-white text-xs px-3 py-1.5 rounded-full font-semibold shadow-lg">
              {activeIndex + 1} / {images.length}
            </div>
          )}

          {/* Dot indicators */}
          {images.length > 1 && (
            <div className="absolute bottom-4 left-1/2 -translate-x-1/2 z-10 flex items-center gap-2">
              {images.map((_, idx) => (
                <button
                  key={idx}
                  onClick={() => setActiveIndex(idx)}
                  className={`rounded-full transition-all duration-300 ${activeIndex === idx
                    ? 'w-6 h-2.5 bg-blue-500 shadow-lg shadow-blue-500/50'
                    : 'w-2.5 h-2.5 bg-white/35 hover:bg-white/60 hover:scale-125'
                    }`}
                />
              ))}
            </div>
          )}

          {/* Keyboard hints */}
          {images.length > 1 && activeIndex === 0 && (
            <div className="absolute bottom-10 left-1/2 -translate-x-1/2 z-10 text-white/40 text-xs pointer-events-none hidden sm:flex items-center gap-2 bg-black/30 px-3 py-1.5 rounded-full backdrop-blur-sm">
              <ChevronLeft size={12} /> <span>← →</span> <ChevronRight size={12} />
              <span className="mx-1">|</span>
              <span>Z</span>
              <span className="mx-1">|</span>
              <span>F</span>
            </div>
          )}
        </div>

        {/* ── Thumbnail strip ── */}
        {images.length > 1 && (
          <div className="flex gap-2.5 overflow-x-auto bg-gradient-to-r from-gray-900 via-gray-800 to-gray-900 px-4 py-3.5 scrollbar-thin scrollbar-thumb-gray-700 scrollbar-track-transparent">
            {images.map((img, idx) => (
              <button
                key={idx}
                onClick={() => setActiveIndex(idx)}
                className={`flex-shrink-0 rounded-xl overflow-hidden border-2 transition-all duration-300 ${activeIndex === idx
                  ? 'border-blue-500 ring-2 ring-blue-500/30 opacity-100 scale-110 shadow-lg shadow-blue-500/20'
                  : 'border-transparent opacity-40 hover:opacity-70 hover:scale-105'
                  }`}
                style={{ width: 56, height: 80 }}
              >
                {img.endsWith('.mp4') ? (
                  <div className="w-full h-full bg-gray-800 flex items-center justify-center">
                    <svg className="w-6 h-6 text-blue-400" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M8 5v14l11-7z" />
                    </svg>
                  </div>
                ) : (
                  <img src={img} alt={`thumb ${idx + 1}`} className="w-full h-full object-cover" loading="lazy" />
                )}
              </button>
            ))}
          </div>
        )}

        {/* ── Content body ── */}
        <div className={`p-6 sm:p-8 ${isFullscreen ? 'hidden' : 'flex-grow'}`}>
          <p className="text-base sm:text-lg text-gray-700 dark:text-gray-300 mb-8 leading-relaxed font-light">
            {project.detailedDescription}
          </p>

          <div className="grid md:grid-cols-2 gap-8 mb-8">
            {/* Features */}
            <div className="space-y-4">
              <h3 className="text-base sm:text-lg font-bold text-gray-900 dark:text-white flex items-center gap-2.5">
                <span className="w-8 h-8 bg-gradient-to-br from-blue-500 to-blue-600 text-white rounded-xl flex items-center justify-center shadow-lg shadow-blue-500/20">
                  <Play size={14} fill="currentColor" />
                </span>
                Highlights
              </h3>
              <ul className="space-y-3 pl-1">
                {project.features.map((feature: string, idx: number) => (
                  <li key={idx} className="flex items-start gap-3 group">
                    <span className="mt-2 w-2 h-2 rounded-full bg-gradient-to-r from-blue-500 to-indigo-500 shrink-0 group-hover:scale-150 transition-transform"></span>
                    <span className="text-gray-600 dark:text-gray-400 text-sm leading-relaxed group-hover:text-gray-900 dark:group-hover:text-gray-200 transition-colors">
                      {feature}
                    </span>
                  </li>
                ))}
              </ul>
            </div>

            {/* Technologies */}
            <div className="space-y-4">
              <h3 className="text-base sm:text-lg font-bold text-gray-900 dark:text-white flex items-center gap-2.5">
                <span className="w-8 h-8 bg-gradient-to-br from-indigo-500 to-purple-600 text-white rounded-xl flex items-center justify-center text-xs font-bold shadow-lg shadow-indigo-500/20">
                  {'</>'}
                </span>
                Tech Stack
              </h3>
              <div className="flex flex-wrap gap-2.5">
                {project.technologies.map((tech: string, idx: number) => (
                  <span
                    key={idx}
                    className="px-4 py-2 bg-gray-50 dark:bg-gray-900 text-gray-700 dark:text-gray-300 rounded-xl border border-gray-200 dark:border-gray-800 text-xs font-semibold hover:border-blue-500/50 hover:bg-blue-500/5 hover:text-blue-600 dark:hover:text-blue-400 transition-all hover:scale-105 hover:shadow-md"
                  >
                    {tech}
                  </span>
                ))}
              </div>
            </div>
          </div>

          {/* Links */}
          <div className="flex flex-col sm:flex-row flex-wrap gap-3 pt-6 border-t border-gray-100 dark:border-gray-800">
            <button
              onClick={handleWhatsAppOrder}
              className="flex items-center justify-center gap-2.5 px-6 py-3.5 bg-gradient-to-r from-green-600 to-emerald-600 text-white rounded-xl hover:from-green-700 hover:to-emerald-700 transition-all shadow-lg hover:shadow-xl hover:-translate-y-0.5 font-semibold text-sm"
            >
              <MessageCircle size={18} /> Order via WhatsApp
            </button>
            {project.github && (
              <a
                href={project.github}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center justify-center gap-2.5 px-6 py-3.5 bg-gray-900 dark:bg-white dark:text-gray-900 text-white rounded-xl hover:bg-gray-700 dark:hover:bg-gray-100 transition-all shadow-lg hover:shadow-xl hover:-translate-y-0.5 font-semibold text-sm"
              >
                <Github size={18} /> Source Code
              </a>
            )}
            {project.store && (
              <a
                href={project.store}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center justify-center gap-2.5 px-6 py-3.5 bg-gradient-to-r from-green-600 to-emerald-600 text-white rounded-xl hover:from-green-700 hover:to-emerald-700 transition-all shadow-lg hover:shadow-xl hover:-translate-y-0.5 font-semibold text-sm"
              >
                <Play size={18} /> Play Store
              </a>
            )}
            {project.appStore && (
              <a
                href={project.appStore}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center justify-center gap-2.5 px-6 py-3.5 bg-gradient-to-r from-blue-600 to-cyan-600 text-white rounded-xl hover:from-blue-700 hover:to-cyan-700 transition-all shadow-lg hover:shadow-xl hover:-translate-y-0.5 font-semibold text-sm"
              >
                <Apple size={18} /> App Store
              </a>
            )}
            {project.live && (
              <a
                href={project.live}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center justify-center gap-2.5 px-6 py-3.5 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-xl hover:from-blue-700 hover:to-indigo-700 transition-all shadow-lg hover:shadow-xl hover:-translate-y-0.5 font-semibold text-sm"
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
