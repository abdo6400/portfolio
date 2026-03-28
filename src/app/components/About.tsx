import { Code2, Award, Users, Zap } from 'lucide-react';
import profileData from '../../imports/profile.json';
import experienceData from '../../imports/experience.json';
import projectsData from '../../imports/projects.json';

export function About() {
  const yearsOfExperience = profileData.bio.match(/\d+\+?\s+years/i)?.[0] || '4+ Years';
  const publishedAppsCount = projectsData.filter(p => p.store || p.appStore).length;
  const appsCount = `${publishedAppsCount}+ Apps`;
  const companies = experienceData.experience.map(exp => exp.company).join(', ');

  const highlights = [
    {
      icon: Code2,
      title: yearsOfExperience,
      description: 'Flutter Development Experience',
    },
    {
      icon: Award,
      title: appsCount,
      description: 'Published on App Store and Play Store',
    },
    {
      icon: Users,
      title: 'Multiple Companies',
      description: companies,
    },
    {
      icon: Zap,
      title: 'Expert in',
      description: 'BLoC & Clean Architecture',
    },
  ];

  return (
    <section id="about" className="py-24 bg-gray-50 dark:bg-gray-900 relative overflow-hidden">
      {/* Decorative Background Elements */}
      <div className="absolute top-1/2 -left-20 w-80 h-80 bg-blue-500/5 rounded-full blur-[100px]"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="text-center mb-16">
          <h2 className="text-4xl sm:text-6xl font-black mb-4 text-gray-900 dark:text-white tracking-tight">
            <span className="text-gradient">About Me</span>
          </h2>
          <div className="w-24 h-1.5 bg-gradient-to-r from-blue-600 to-indigo-600 mx-auto rounded-full shadow-sm"></div>
        </div>

        <div className="grid lg:grid-cols-2 gap-16 items-center">
          {/* Bio */}
          <div className="space-y-6">
            <p className="text-xl text-gray-700 dark:text-gray-300 leading-relaxed font-medium">
              {profileData.bio}
            </p>
            <p className="text-lg text-gray-600 dark:text-gray-400 leading-relaxed">
              I'm passionate about creating scalable mobile solutions that solve real-world problems.
              My expertise spans across various domains including E-commerce, AI integration, Real Estate,
              and Financial applications.
            </p>
              <div className="inline-flex items-center gap-2 px-4 py-2 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 rounded-xl font-bold text-sm border border-blue-100 dark:border-blue-800">
                <Zap size={16} />
                <span>Available for new opportunities</span>
              </div>
          </div>

          {/* Highlights Grid */}
          <div className="grid sm:grid-cols-2 gap-6">
            {highlights.map((highlight, index) => {
              const Icon = highlight.icon;
              return (
                <div
                  key={index}
                  className="p-8 glass-card hover-lift rounded-[2rem] border-white/40 dark:border-gray-800/50 group"
                >
                  <div className="w-14 h-14 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-2xl flex items-center justify-center mb-6 shadow-lg group-hover:scale-110 transition-transform duration-300">
                    <Icon className="text-white" size={28} />
                  </div>
                  <h3 className="text-2xl font-bold text-gray-900 dark:text-white mb-2">
                    {highlight.title}
                  </h3>
                  <p className="text-gray-600 dark:text-gray-400 leading-relaxed text-sm">{highlight.description}</p>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </section>
  );
}
