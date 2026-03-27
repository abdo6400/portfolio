import { Code2, Award, Users, Zap } from 'lucide-react';
import profileData from '../../imports/profile.json';
import experienceData from '../../imports/experience.json';
import projectsData from '../../imports/projects.json';

export function About() {
  const yearsOfExperience = profileData.bio.match(/\d+\+?\s+years/i)?.[0] || '4+ Years';
  const appsCount = `${projectsData.length}+ Apps`;
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
    <section id="about" className="py-20 bg-white dark:bg-gray-950">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-16">
          <h2 className="text-4xl sm:text-5xl mb-4 text-gray-900 dark:text-white">
            About Me
          </h2>
          <div className="w-20 h-1 bg-gradient-to-r from-blue-600 to-indigo-600 mx-auto rounded-full"></div>
        </div>

        <div className="grid lg:grid-cols-2 gap-12 items-center">
          {/* Bio */}
          <div>
            <p className="text-lg text-gray-700 dark:text-gray-300 leading-relaxed mb-6">
              {profileData.bio}
            </p>
            <p className="text-lg text-gray-700 dark:text-gray-300 leading-relaxed">
              I'm passionate about creating scalable mobile solutions that solve real-world problems.
              My expertise spans across various domains including E-commerce, AI integration, Real Estate,
              and Financial applications.
            </p>
          </div>

          {/* Highlights Grid */}
          <div className="grid sm:grid-cols-2 gap-6">
            {highlights.map((highlight, index) => {
              const Icon = highlight.icon;
              return (
                <div
                  key={index}
                  className="p-6 bg-gradient-to-br from-blue-50 to-indigo-50 dark:from-gray-900 dark:to-blue-950 rounded-xl border border-blue-100 dark:border-gray-800 hover:shadow-xl dark:hover:shadow-blue-900/20 transition-all hover:scale-105"
                >
                  <div className="w-12 h-12 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-lg flex items-center justify-center mb-4 shadow-lg">
                    <Icon className="text-white" size={24} />
                  </div>
                  <h3 className="text-xl text-gray-900 dark:text-white mb-2">
                    {highlight.title}
                  </h3>
                  <p className="text-gray-600 dark:text-gray-400">{highlight.description}</p>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </section>
  );
}
