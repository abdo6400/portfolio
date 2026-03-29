import { Github, Linkedin, Mail, Phone, MapPin, Download, ArrowRight, Sparkles, ChevronDown, Code2, Smartphone, Zap, Star } from 'lucide-react';
import { motion } from 'motion/react';
import profileData from '../../imports/profile.json';
import profileImage from 'figma:asset/197868cc9149d5b4b12480e05e963f942645a274.png';
import mascotImage from 'figma:asset/5663d54f4cf091ab3318cb77a4ee222db0fd7688.png';
import { Link } from 'react-router';

export function HomePage() {
  return (
    <div className="min-h-screen pt-28 pb-20 mesh-gradient overflow-hidden relative">
      {/* Enhanced Decorative Blur Orbs */}
      <div className="absolute top-0 -left-20 w-80 h-80 bg-cyan-400/20 rounded-full blur-3xl animate-pulse"></div>
      <div className="absolute bottom-0 -right-20 w-[400px] h-[400px] bg-violet-400/20 rounded-full blur-3xl animate-pulse delay-1000"></div>
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[700px] h-[700px] bg-fuchsia-400/10 rounded-full blur-[120px]"></div>
      <div className="absolute top-1/4 right-1/4 w-48 h-48 bg-emerald-400/15 rounded-full blur-[80px] animate-pulse delay-500"></div>
      <div className="absolute bottom-1/4 left-1/3 w-56 h-56 bg-rose-400/10 rounded-full blur-[90px] animate-pulse delay-700"></div>

      {/* Floating Particles */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        {[...Array(25)].map((_, i) => (
          <motion.div
            key={i}
            className="absolute w-2 h-2 bg-cyan-500/20 rounded-full"
            style={{
              left: `${Math.random() * 100}%`,
              top: `${Math.random() * 100}%`,
            }}
            animate={{
              y: [0, -30, 0],
              opacity: [0.2, 0.5, 0.2],
            }}
            transition={{
              duration: 3 + Math.random() * 2,
              repeat: Infinity,
              delay: Math.random() * 2,
            }}
          />
        ))}
      </div>

      <div className="max-w-7xl mx-auto px-6 sm:px-8 lg:px-10 relative z-10">
        <div className="flex flex-col lg:flex-row items-center justify-between gap-16">
          {/* Text Content */}
          <motion.div
            initial={{ opacity: 0, x: -50 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.8, ease: "easeOut" }}
            className="flex-1 text-center lg:text-left"
          >
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.2, duration: 0.6 }}
              className="inline-flex items-center px-6 py-3 glass-morphism rounded-full mb-10 shadow-lg border border-cyan-200/30 dark:border-cyan-700/30 hover:scale-105 transition-transform"
            >
              <Sparkles size={18} className="mr-2.5 text-cyan-500 animate-pulse" />
              <span className="text-gray-700 dark:text-gray-300 font-semibold tracking-wide">Available for new opportunities</span>
            </motion.div>

            <motion.h1
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.3, duration: 0.7 }}
              className="text-5xl sm:text-7xl lg:text-8xl mb-5 font-black tracking-tight text-gray-900 dark:text-white"
            >
              <span className="text-gradient inline-block hover:scale-105 transition-transform duration-300 cursor-default">
                {profileData.name}
              </span>
            </motion.h1>

            <motion.h2
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.4, duration: 0.7 }}
              className="text-2xl sm:text-3xl lg:text-4xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-gray-900 via-cyan-600 to-violet-600 dark:from-white dark:via-cyan-400 dark:to-violet-400 mb-8"
            >
              {profileData.title}
            </motion.h2>

            <motion.p
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.5, duration: 0.7 }}
              className="text-lg sm:text-xl text-gray-600 dark:text-gray-400 mb-12 max-w-2xl leading-relaxed"
            >
              {profileData.subtitle}
            </motion.p>

            {/* Contact Info - Glass Style */}
            <motion.div
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.6, duration: 0.7 }}
              className="flex flex-wrap gap-4 justify-center lg:justify-start mb-12 text-gray-600 dark:text-gray-400"
            >
              <div className="flex items-center gap-2.5 px-5 py-3 glass-card rounded-2xl hover:scale-105 transition-transform hover:shadow-lg">
                <MapPin size={20} className="text-cyan-600 dark:text-cyan-400" />
                <span className="text-sm font-semibold">{profileData.location}</span>
              </div>
              <a href={`mailto:${profileData.email}`} className="flex items-center gap-2.5 px-5 py-3 glass-card rounded-2xl hover:text-cyan-600 transition-all hover:scale-105 hover:shadow-lg">
                <Mail size={20} className="text-cyan-600 dark:text-cyan-400" />
                <span className="text-sm font-semibold">{profileData.email}</span>
              </a>
              <div className="flex items-center gap-2.5 px-5 py-3 glass-card rounded-2xl hover:scale-105 transition-transform hover:shadow-lg">
                <Phone size={20} className="text-cyan-600 dark:text-cyan-400" />
                <span className="text-sm font-semibold">{profileData.phone}</span>
              </div>
            </motion.div>

            <motion.div
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.7, duration: 0.7 }}
              className="flex flex-col sm:flex-row items-center gap-6 justify-center lg:justify-start"
            >
              {/* CTA Button */}
              <a
                href={profileData.cvFile}
                download
                className="group relative inline-flex items-center gap-3 px-12 py-5 bg-gradient-to-r from-cyan-600 to-violet-600 text-white rounded-2xl transition-all shadow-xl shadow-cyan-500/25 hover:shadow-2xl hover:shadow-cyan-500/40 font-bold active:scale-95 hover:scale-105 overflow-hidden"
              >
                <span className="absolute inset-0 bg-white/20 opacity-0 group-hover:opacity-100 transition-opacity"></span>
                <span className="absolute inset-0 shimmer"></span>
                <Download size={22} className="group-hover:translate-y-1 transition-transform relative z-10" />
                <span className="relative z-10">Download Resume</span>
              </a>

              {/* View Projects Button */}
              <Link
                to="/projects"
                className="group inline-flex items-center gap-3 px-12 py-5 glass-card rounded-2xl font-bold text-gray-700 dark:text-gray-300 hover:text-cyan-600 dark:hover:text-cyan-400 transition-all hover:scale-105 active:scale-95 hover:shadow-xl"
              >
                <span>View Projects</span>
                <ArrowRight size={22} className="group-hover:translate-x-1 transition-transform" />
              </Link>

              {/* Social Links */}
              <div className="flex gap-5">
                <a
                  href={profileData.socialLinks.github}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="w-16 h-16 glass-card flex items-center justify-center rounded-2xl hover:bg-gray-900 hover:text-white dark:hover:bg-white dark:hover:text-black transition-all hover:scale-110 active:scale-95 group shadow-lg hover:shadow-xl"
                >
                  <Github size={26} className="group-hover:rotate-12 transition-transform" />
                </a>
                <a
                  href={profileData.socialLinks.linkedin}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="w-16 h-16 glass-card flex items-center justify-center rounded-2xl hover:bg-cyan-600 hover:text-white transition-all hover:scale-110 active:scale-95 group shadow-lg hover:shadow-xl"
                >
                  <Linkedin size={26} className="group-hover:-rotate-12 transition-transform" />
                </a>
              </div>
            </motion.div>
          </motion.div>

          {/* Images Section */}
          <motion.div
            initial={{ opacity: 0, x: 50 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.8, ease: "easeOut" }}
            className="flex-1 relative flex justify-center items-center"
          >
            {/* Enhanced Background Design */}
            <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[500px] h-[500px]">
              {/* Main gradient orb */}
              <div className="absolute inset-0 bg-gradient-to-br from-cyan-500/30 via-violet-500/30 to-fuchsia-500/30 rounded-full blur-[80px]"></div>

              {/* Secondary orbs */}
              <div className="absolute top-0 left-1/4 w-40 h-40 bg-cyan-400/40 rounded-full blur-[60px]"></div>
              <div className="absolute bottom-0 right-1/4 w-48 h-48 bg-violet-400/40 rounded-full blur-[60px]"></div>
              <div className="absolute top-1/3 right-0 w-32 h-32 bg-fuchsia-400/40 rounded-full blur-[50px]"></div>
              <div className="absolute bottom-1/3 left-0 w-36 h-36 bg-emerald-400/40 rounded-full blur-[50px]"></div>

              {/* Decorative rings */}
              <div className="absolute inset-8 border-2 border-cyan-500/20 rounded-full"></div>
              <div className="absolute inset-16 border-2 border-violet-500/20 rounded-full"></div>
              <div className="absolute inset-24 border-2 border-fuchsia-500/20 rounded-full"></div>
            </div>

            <div className="relative max-w-md mx-auto">
              {/* Profile Image Container */}
              <motion.div
                initial={{ scale: 0.8, rotate: -5 }}
                animate={{ scale: 1, rotate: 0 }}
                transition={{ delay: 0.4, duration: 0.8, type: "spring" }}
                className="relative z-10 w-72 h-72 sm:w-[400px] sm:h-[400px] mx-auto animate-float"
              >
                {/* Gradient border */}
                <div className="absolute inset-0 rounded-[2.5rem] bg-gradient-to-tr from-cyan-500 via-violet-500 to-fuchsia-500 p-2 shadow-2xl rotate-3 scale-[1.02]">
                  <div className="w-full h-full bg-white dark:bg-gray-950 rounded-[2.3rem]"></div>
                </div>

                {/* Glow effect behind image */}
                <div className="absolute inset-4 rounded-[2rem] bg-gradient-to-br from-cyan-500/20 via-violet-500/20 to-fuchsia-500/20 blur-xl"></div>

                <img
                  src={profileImage}
                  alt={profileData.name}
                  className="relative z-10 w-full h-full object-cover rounded-[2.5rem] shadow-2xl border-4 border-white dark:border-gray-900"
                />

                {/* Floating Tech Badges */}
                <motion.div
                  initial={{ scale: 0 }}
                  animate={{ scale: 1 }}
                  transition={{ delay: 0.8, type: "spring", stiffness: 200 }}
                  className="absolute -top-5 -right-5 w-24 h-24 bg-white dark:bg-gray-900 rounded-3xl shadow-2xl flex items-center justify-center animate-bounce duration-[4000ms] border border-cyan-100 dark:border-gray-800 p-3.5"
                >
                  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg" alt="Flutter" className="w-full h-full object-contain" />
                </motion.div>

                <motion.div
                  initial={{ scale: 0, x: 20 }}
                  animate={{ scale: 1, x: 0 }}
                  transition={{ delay: 1, type: "spring", stiffness: 200 }}
                  className="absolute -bottom-3 -left-5 w-20 h-20 bg-white dark:bg-gray-900 rounded-2xl shadow-xl flex items-center justify-center animate-bounce duration-[5000ms] border border-emerald-100 dark:border-gray-800 p-3"
                >
                  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/dart/dart-original.svg" alt="Dart" className="w-full h-full object-contain" />
                </motion.div>
              </motion.div>

              {/* Mascot Image */}
              <motion.div
                initial={{ opacity: 0, y: 50 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 1, duration: 0.8 }}
                className="hidden lg:block absolute -bottom-20 -right-14 w-64 h-64 animate-float-delayed z-20"
              >
                <img
                  src={mascotImage}
                  alt="Flutter Developer Mascot"
                  className="w-full h-full object-contain drop-shadow-[0_20px_50px_rgba(6,182,212,0.4)]"
                />
              </motion.div>
            </div>
          </motion.div>
        </div>

        {/* Quick Stats Section */}
        <motion.div
          initial={{ opacity: 0, y: 50 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 1.2, duration: 0.8 }}
          className="mt-28 grid grid-cols-2 md:grid-cols-4 gap-8"
        >
          {[
            { label: 'Years Experience', value: '4+', icon: Code2, color: 'from-cyan-500 to-blue-500' },
            { label: 'Apps Published', value: '9+', icon: Smartphone, color: 'from-violet-500 to-purple-500' },
            { label: 'Projects Completed', value: '15+', icon: Star, color: 'from-fuchsia-500 to-pink-500' },
            { label: 'Technologies', value: '15+', icon: Zap, color: 'from-emerald-500 to-teal-500' },
          ].map((stat, index) => {
            const Icon = stat.icon;
            return (
              <motion.div
                key={stat.label}
                initial={{ opacity: 0, y: 30 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 1.3 + index * 0.1, duration: 0.6 }}
                className="glass-card p-8 rounded-3xl text-center hover:scale-105 transition-transform hover:shadow-xl group"
              >
                <div className={`w-14 h-14 bg-gradient-to-br ${stat.color} rounded-2xl flex items-center justify-center mx-auto mb-5 shadow-lg group-hover:scale-110 transition-transform`}>
                  <Icon className="text-white" size={28} />
                </div>
                <div className="text-4xl sm:text-5xl font-black text-gradient mb-3">{stat.value}</div>
                <div className="text-sm text-gray-600 dark:text-gray-400 font-semibold">{stat.label}</div>
              </motion.div>
            );
          })}
        </motion.div>

        {/* Scroll Indicator */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 2, duration: 0.8 }}
          className="mt-20 flex justify-center"
        >
          <Link
            to="/about"
            className="flex flex-col items-center gap-3 text-gray-500 dark:text-gray-400 hover:text-cyan-600 dark:hover:text-cyan-400 transition-colors group"
          >
            <span className="text-sm font-semibold">Learn more about me</span>
            <motion.div
              animate={{ y: [0, 8, 0] }}
              transition={{ duration: 1.5, repeat: Infinity }}
            >
              <ChevronDown size={28} className="group-hover:scale-110 transition-transform" />
            </motion.div>
          </Link>
        </motion.div>
      </div>
    </div>
  );
}
