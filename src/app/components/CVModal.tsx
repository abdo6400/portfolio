import React, { useEffect } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { X, Download, Eye, Maximize2, ExternalLink } from 'lucide-react';

interface CVModalProps {
  isOpen: boolean;
  onClose: () => void;
  cvUrl: string;
}

export const CVModal: React.FC<CVModalProps> = ({ isOpen, onClose, cvUrl }) => {
  // Prevent body scroll when modal is open
  useEffect(() => {
    if (isOpen) {
      document.body.style.overflow = 'hidden';
    } else {
      document.body.style.overflow = '';
    }
    return () => {
      document.body.style.overflow = '';
    };
  }, [isOpen]);

  // Handle Escape key
  useEffect(() => {
    const handleEsc = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose();
    };
    window.addEventListener('keydown', handleEsc);
    return () => window.removeEventListener('keydown', handleEsc);
  }, [onClose]);

  return (
    <AnimatePresence>
      {isOpen && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 sm:p-6 md:p-10">
          {/* Backdrop */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={onClose}
            className="absolute inset-0 bg-black/80 backdrop-blur-xl sm:backdrop-blur-2xl"
          />

          {/* Modal Content */}
          <motion.div
            initial={{ opacity: 0, scale: 0.9, y: 20 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.9, y: 20 }}
            transition={{ type: 'spring', damping: 25, stiffness: 300 }}
            className="relative w-full max-w-5xl h-full bg-white dark:bg-gray-950 rounded-3xl shadow-2xl overflow-hidden border border-gray-200/50 dark:border-gray-800/50 flex flex-col"
          >
            {/* Header */}
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800 bg-white/80 dark:bg-gray-950/80 backdrop-blur-md z-10">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-blue-600 to-indigo-600 flex items-center justify-center text-white shadow-lg shadow-blue-500/20">
                  <Eye size={20} />
                </div>
                <div>
                  <h3 className="text-lg font-bold text-gray-900 dark:text-white leading-tight">Curriculum Vitae</h3>
                  <p className="text-xs text-gray-500 dark:text-gray-400 font-medium tracking-wide flex items-center gap-1">
                    Preview Mode <span className="w-1 h-1 rounded-full bg-green-500 animate-pulse"></span>
                  </p>
                </div>
              </div>

              <div className="flex items-center gap-2">
                <a
                  href={cvUrl}
                  download
                  className="p-2.5 rounded-xl text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 transition-all hover:scale-110 active:scale-95 group relative"
                  title="Download PDF"
                >
                  <Download size={20} className="group-hover:translate-y-0.5 transition-transform" />
                </a>
                <button
                  onClick={() => window.open(cvUrl, '_blank')}
                  className="p-2.5 rounded-xl text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 transition-all hover:scale-110 active:scale-95"
                  title="Open in New Tab"
                >
                  <ExternalLink size={20} />
                </button>
                <div className="w-px h-6 bg-gray-200 dark:bg-gray-800 mx-1"></div>
                <button
                  onClick={onClose}
                  className="p-2.5 rounded-xl text-gray-500 dark:text-gray-400 hover:bg-red-50 dark:hover:bg-red-900/20 hover:text-red-500 transition-all hover:scale-110 active:scale-95"
                  aria-label="Close"
                >
                  <X size={22} />
                </button>
              </div>
            </div>

            {/* Viewport */}
            <div className="flex-grow bg-gray-100 dark:bg-gray-900/50 relative group">
              <iframe
                src={`${cvUrl}#toolbar=0&navpanes=0&scrollbar=0`}
                className="w-full h-full border-none"
                title="CV Preview"
              />
              
              {/* Overlay for small screens to hint scrolling */}
              <div className="absolute bottom-6 left-1/2 -translate-x-1/2 px-4 py-2 bg-black/60 backdrop-blur-md rounded-full text-white text-[10px] font-bold uppercase tracking-widest opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none border border-white/10 shadow-2xl">
                Scroll to view more
              </div>
            </div>

            {/* Footer / Status Bar */}
            <div className="px-6 py-3 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-950/50 flex items-center justify-between text-[10px] font-bold uppercase tracking-[0.2em] text-gray-500 dark:text-gray-400">
              <span>Secured Preview</span>
              <div className="flex items-center gap-4">
                <span className="flex items-center gap-1.5">
                  <span className="w-1.5 h-1.5 rounded-full bg-blue-500"></span>
                  PDF Document
                </span>
                <span className="flex items-center gap-1.5">
                  <span className="w-1.5 h-1.5 rounded-full bg-indigo-500"></span>
                  A4 Standard
                </span>
              </div>
            </div>
          </motion.div>
        </div>
      )}
    </AnimatePresence>
  );
};
