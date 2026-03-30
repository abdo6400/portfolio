import { useState } from 'react';
import { Github, Linkedin, Mail, Phone, MapPin, Download, Eye } from 'lucide-react';
import profileData from '../../imports/profile.json';
import profileImage from 'figma:asset/197868cc9149d5b4b12480e05e963f942645a274.png';
import mascotImage from 'figma:asset/5663d54f4cf091ab3318cb77a4ee222db0fd7688.png';
import { CVModal } from './CVModal';

export function Hero() {
  const [isCVOpen, setIsCVOpen] = useState(false);
  return (
    <section id="home" className="pt-24 pb-16 mesh-gradient overflow-hidden relative">
      {/* Decorative Blur Orbs */}
      <div className="absolute top-0 -left-20 w-72 h-72 bg-blue-400/20 rounded-full blur-3xl animate-pulse"></div>
      <div className="absolute bottom-0 -right-20 w-96 h-96 bg-indigo-400/20 rounded-full blur-3xl animate-pulse delay-1000"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="flex flex-col lg:flex-row items-center justify-between gap-12">
          {/* Text Content */}
          <div className="flex-1 text-center lg:text-left">
            <div className="inline-flex items-center px-5 py-2 glass-morphism rounded-full mb-8 shadow-sm">
              <span className="mr-2 animate-bounce">👋</span>
              <span className="text-gray-700 dark:text-gray-300 font-medium tracking-wide">Hello, I'm</span>
            </div>
            
            <h1 className="text-5xl sm:text-6xl lg:text-8xl mb-4 font-black tracking-tight text-gray-900 dark:text-white">
              <span className="text-gradient inline-block hover:scale-105 transition-transform duration-300 cursor-default">
                {profileData.name}
              </span>
            </h1>
            
            <h2 className="text-2xl sm:text-4xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-gray-900 via-blue-600 to-indigo-600 dark:from-white dark:via-blue-400 dark:to-indigo-400 mb-6">
              {profileData.title}
            </h2>
            
            <p className="text-lg sm:text-xl text-gray-600 dark:text-gray-400 mb-10 max-w-2xl leading-relaxed">
              {profileData.subtitle}
            </p>

            {/* Contact Info - Glass Style */}
            <div className="flex flex-wrap gap-4 justify-center lg:justify-start mb-10 text-gray-600 dark:text-gray-400">
              <div className="flex items-center gap-2 px-4 py-2 glass-card rounded-xl">
                <MapPin size={18} className="text-blue-600 dark:text-blue-400" />
                <span className="text-sm font-medium">{profileData.location}</span>
              </div>
              <div className="flex items-center gap-2 px-4 py-2 glass-card rounded-xl hover:text-blue-600 transition-colors cursor-pointer">
                <Mail size={18} className="text-blue-600 dark:text-blue-400" />
                <a href={`mailto:${profileData.email}`} className="text-sm font-medium">
                  {profileData.email}
                </a>
              </div>
              <div className="flex items-center gap-2 px-4 py-2 glass-card rounded-xl">
                <Phone size={18} className="text-blue-600 dark:text-blue-400" />
                <span className="text-sm font-medium">{profileData.phone}</span>
              </div>
            </div>

            <div className="flex flex-col sm:flex-row items-center gap-6 justify-center lg:justify-start">
              {/* CTA Buttons */}
              <div className="flex flex-col sm:flex-row items-center gap-4">
                <button
                  onClick={() => setIsCVOpen(true)}
                  className="group relative inline-flex items-center gap-3 px-8 py-4 bg-white dark:bg-gray-950 text-gray-900 dark:text-gray-100 rounded-2xl transition-all border border-gray-200 dark:border-gray-800 hover:border-blue-500/50 hover:bg-blue-50/50 dark:hover:bg-blue-900/10 font-bold active:scale-95 shadow-lg shadow-blue-500/5"
                >
                  <Eye size={20} className="group-hover:scale-110 transition-transform" />
                  <span>View CV</span>
                  <div className="absolute inset-0 rounded-2xl transition-opacity opacity-0 group-hover:opacity-10 shadow-[0_0_20px_rgba(37,99,235,0.3)]"></div>
                </button>

                <a
                  href={profileData.cvFile}
                  download
                  className="group relative inline-flex items-center gap-3 px-10 py-4 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-2xl transition-all shadow-xl shadow-blue-500/25 hover:shadow-2xl hover:shadow-blue-500/40 font-bold active:scale-95"
                >
                  <Download size={20} className="group-hover:translate-y-1 transition-transform" />
                  <span>Download</span>
                  <div className="absolute inset-0 rounded-2xl bg-white/20 opacity-0 group-hover:opacity-100 transition-opacity"></div>
                </a>
              </div>

              {/* Social Links */}
              <div className="flex gap-4">
                <a
                  href={profileData.socialLinks.github}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="w-14 h-14 glass-card flex items-center justify-center rounded-2xl hover:bg-gray-900 hover:text-white dark:hover:bg-white dark:hover:text-black transition-all hover:scale-110 active:scale-95 group shadow-lg"
                >
                  <Github size={24} className="group-hover:rotate-12 transition-transform" />
                </a>
                <a
                  href={profileData.socialLinks.linkedin}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="w-14 h-14 glass-card flex items-center justify-center rounded-2xl hover:bg-blue-600 hover:text-white transition-all hover:scale-110 active:scale-95 group shadow-lg"
                >
                  <Linkedin size={24} className="group-hover:-rotate-12 transition-transform" />
                </a>
              </div>
            </div>
          </div>

          {/* Images Section */}
          <div className="flex-1 relative flex justify-center items-center">
            {/* Background Blur Backlight */}
            <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-80 h-80 bg-blue-600/30 dark:bg-blue-500/20 rounded-full blur-[100px]"></div>
            
            <div className="relative max-w-md mx-auto">
              {/* Profile Image Container */}
              <div className="relative z-10 w-64 h-64 sm:w-96 sm:h-96 mx-auto animate-float">
                <div className="absolute inset-0 rounded-[2.5rem] bg-gradient-to-tr from-blue-600 to-indigo-600 p-1.5 shadow-2xl rotate-3 scale-[1.02]">
                  <div className="w-full h-full bg-white dark:bg-gray-950 rounded-[2.4rem]"></div>
                </div>
                <img
                  src={profileImage}
                  alt={profileData.name}
                  className="relative z-10 w-full h-full object-cover rounded-[2.5rem] shadow-2xl border-4 border-white dark:border-gray-900"
                />
                
                {/* Floating Tech Badge (Simulated) */}
                <div className="absolute -top-4 -right-4 w-20 h-20 bg-white dark:bg-gray-900 rounded-3xl shadow-2xl flex items-center justify-center animate-bounce duration-[4000ms] border border-blue-100 dark:border-gray-800 p-3">
                    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg" alt="Flutter" className="w-full h-full object-contain" />
                </div>
              </div>
              
              {/* Mascot Image */}
              <div className="hidden lg:block absolute -bottom-16 -right-12 w-56 h-56 animate-float-delayed z-20">
                <img
                  src={mascotImage}
                  alt="Flutter Developer Mascot"
                  className="w-full h-full object-contain drop-shadow-[0_20px_50px_rgba(37,99,235,0.4)]"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
      <CVModal isOpen={isCVOpen} onClose={() => setIsCVOpen(false)} cvUrl={profileData.cvFile} />
    </section>
  );
}
