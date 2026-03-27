import { Github, Linkedin, Mail, Phone, MapPin, Download } from 'lucide-react';
import profileData from '../../imports/profile.json';
import profileImage from 'figma:asset/197868cc9149d5b4b12480e05e963f942645a274.png';
import mascotImage from 'figma:asset/5663d54f4cf091ab3318cb77a4ee222db0fd7688.png';

export function Hero() {
  return (
    <section id="home" className="pt-24 pb-16 bg-gradient-to-br from-blue-50 via-white to-indigo-50 dark:from-gray-900 dark:via-gray-900 dark:to-blue-950">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex flex-col lg:flex-row items-center justify-between gap-12">
          {/* Text Content */}
          <div className="flex-1 text-center lg:text-left">
            <div className="inline-flex items-center px-4 py-2 bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-300 rounded-full mb-6">
              <span className="mr-2">👋</span>
              <span>Hello, I'm</span>
            </div>
            
            <h1 className="text-5xl sm:text-6xl lg:text-7xl mb-4 text-gray-900 dark:text-white">
              {profileData.name}
            </h1>
            
            <h2 className="text-2xl sm:text-3xl text-blue-600 dark:text-blue-400 mb-4">
              {profileData.title}
            </h2>
            
            <p className="text-lg sm:text-xl text-gray-600 dark:text-gray-400 mb-8 max-w-2xl">
              {profileData.subtitle}
            </p>

            {/* Contact Info */}
            <div className="flex flex-wrap gap-4 justify-center lg:justify-start mb-8 text-gray-600 dark:text-gray-400">
              <div className="flex items-center gap-2">
                <MapPin size={18} className="text-blue-600 dark:text-blue-400" />
                <span>{profileData.location}</span>
              </div>
              <div className="flex items-center gap-2">
                <Mail size={18} className="text-blue-600 dark:text-blue-400" />
                <a href={`mailto:${profileData.email}`} className="hover:text-blue-600 dark:hover:text-blue-400">
                  {profileData.email}
                </a>
              </div>
              <div className="flex items-center gap-2">
                <Phone size={18} className="text-blue-600 dark:text-blue-400" />
                <span>{profileData.phone}</span>
              </div>
            </div>

            {/* Social Links */}
            <div className="flex gap-4 justify-center lg:justify-start mb-8">
              <a
                href={profileData.socialLinks.github}
                target="_blank"
                rel="noopener noreferrer"
                className="p-3 bg-gray-900 dark:bg-gray-800 text-white rounded-full hover:bg-gray-800 dark:hover:bg-gray-700 transition-all hover:scale-110"
              >
                <Github size={24} />
              </a>
              <a
                href={profileData.socialLinks.linkedin}
                target="_blank"
                rel="noopener noreferrer"
                className="p-3 bg-blue-600 dark:bg-blue-700 text-white rounded-full hover:bg-blue-700 dark:hover:bg-blue-600 transition-all hover:scale-110"
              >
                <Linkedin size={24} />
              </a>
            </div>

            {/* CTA Button */}
            <a
              href={profileData.cvFile}
              download
              className="inline-flex items-center gap-2 px-8 py-4 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-full hover:from-blue-700 hover:to-indigo-700 transition-all shadow-lg hover:shadow-xl hover:scale-105"
            >
              <Download size={20} />
              <span>Download CV</span>
            </a>
          </div>

          {/* Images */}
          <div className="flex-1 relative">
            <div className="relative max-w-md mx-auto">
              {/* Profile Image */}
              <div className="relative z-10 w-64 h-64 sm:w-80 sm:h-80 mx-auto mb-8 lg:mb-0">
                <img
                  src={profileImage}
                  alt={profileData.name}
                  className="w-full h-full object-cover rounded-full border-8 border-white dark:border-gray-800 shadow-2xl"
                />
                <div className="absolute inset-0 rounded-full bg-gradient-to-tr from-blue-600/20 to-transparent"></div>
              </div>
              
              {/* Mascot Image */}
              <div className="hidden lg:block absolute -bottom-8 -right-8 w-48 h-48 animate-bounce">
                <img
                  src={mascotImage}
                  alt="Flutter Developer Mascot"
                  className="w-full h-full object-contain drop-shadow-2xl"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
