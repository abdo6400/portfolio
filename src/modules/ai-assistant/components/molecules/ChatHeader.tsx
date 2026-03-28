import React from 'react';
import { Sparkles, X, RotateCcw } from 'lucide-react';
import profile from '../../../../imports/profile.json';
import profileImage from 'figma:asset/197868cc9149d5b4b12480e05e963f942645a274.png';

interface ChatHeaderProps {
  onClose: () => void;
  onClear: () => void;
}

export const ChatHeader: React.FC<ChatHeaderProps> = ({ onClose, onClear }) => {
  return (
    <div className="flex items-center justify-between p-4 border-b border-slate-700 bg-slate-900/80 backdrop-blur-md rounded-t-3xl">
      <div className="flex items-center gap-3">
        <div className="relative">
          <img
            src={profileImage}
            alt={profile.name}
            className="w-10 h-10 rounded-full border-2 border-cyan-500/30 object-cover shadow-sm shadow-cyan-900/10"
          />
          <div className="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border-2 border-slate-900 ring-2 ring-transparent animate-pulse" />
        </div>
        <div className="flex flex-col">
          <h3 className="text-sm font-semibold text-slate-100 flex items-center gap-1.5 leading-tight">
            AI Assistant <Sparkles size={12} className="text-cyan-400" />
          </h3>
          <span className="text-[10px] text-slate-400 font-medium">Online • Powered by Gemini</span>
        </div>
      </div>
      <div className="flex items-center gap-1.5">
        <button
          onClick={onClear}
          title="Clear Chat"
          className="p-2 text-slate-400 hover:text-cyan-400 hover:bg-slate-800 rounded-full transition-all duration-200"
        >
          <RotateCcw size={18} />
        </button>
        <button
          onClick={onClose}
          title="Close Chat"
          className="p-2 text-slate-400 hover:text-red-400 hover:bg-slate-800 rounded-full transition-all duration-200"
        >
          <X size={20} />
        </button>
      </div>
    </div>
  );
};
