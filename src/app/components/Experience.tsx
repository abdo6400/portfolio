import { Briefcase, GraduationCap, MapPin, Calendar } from 'lucide-react';
import experienceData from '../../imports/experience.json';

export function Experience() {
  return (
    <section id="experience" className="py-24 bg-gray-50 dark:bg-gray-900 relative overflow-hidden">
      {/* Decorative Background Elements */}
      <div className="absolute top-1/2 -right-20 w-80 h-80 bg-blue-500/5 rounded-full blur-[100px]"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="text-center mb-16">
          <h2 className="text-4xl sm:text-6xl font-black mb-4 text-gray-900 dark:text-white tracking-tight">
            <span className="text-gradient">Experience & Education</span>
          </h2>
          <div className="w-24 h-1.5 bg-gradient-to-r from-blue-600 to-indigo-600 mx-auto rounded-full shadow-sm"></div>
        </div>

        <div className="grid lg:grid-cols-2 gap-16">
          {/* Work Experience */}
          <div className="space-y-10">
            <div className="flex items-center gap-4 mb-10">
              <div className="w-14 h-14 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-2xl flex items-center justify-center shadow-lg">
                <Briefcase className="text-white" size={28} />
              </div>
              <h3 className="text-3xl font-bold text-gray-900 dark:text-white">Work Experience</h3>
            </div>

            <div className="space-y-12">
              {experienceData.experience.map((exp) => (
                <div
                  key={exp.id}
                  className="relative pl-10 pb-1 border-l-2 border-blue-500/20 dark:border-blue-900/50 last:border-l-0 last:pb-0"
                >
                  <div className="absolute -left-2.5 top-0 w-5 h-5 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-full shadow-xl ring-4 ring-white dark:ring-gray-900"></div>
                  
                  <div className="glass-card hover-lift p-8 rounded-[2rem] border-white/40 dark:border-gray-800/50 group">
                    <h4 className="text-2xl font-bold text-gray-900 dark:text-white mb-2 group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors">
                      {exp.title}
                    </h4>
                    <div className="text-lg font-bold text-blue-600 dark:text-blue-400 mb-4 px-3 py-1 bg-blue-500/5 dark:bg-blue-400/5 rounded-lg inline-block">
                      {exp.company}
                    </div>
                    
                    <div className="flex flex-wrap gap-4 text-sm font-semibold text-gray-500 dark:text-gray-400 mb-6">
                      <div className="flex items-center gap-2">
                        <MapPin size={16} className="text-blue-500" />
                        <span>{exp.location}</span>
                      </div>
                      <div className="flex items-center gap-2 text-indigo-500">
                        <Calendar size={16} />
                        <span>{exp.startDate} - {exp.endDate}</span>
                      </div>
                    </div>

                    <p className="text-gray-600 dark:text-gray-400 mb-6 leading-relaxed">{exp.description}</p>

                    <ul className="space-y-3">
                      {exp.highlights.map((highlight, idx) => (
                        <li key={idx} className="flex items-start gap-3 text-sm text-gray-600 dark:text-gray-400">
                          <span className="flex-shrink-0 w-1.5 h-1.5 rounded-full bg-blue-600 dark:bg-blue-400 mt-2"></span>
                          <span>{highlight}</span>
                        </li>
                      ))}
                    </ul>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Education */}
          <div className="space-y-10">
            <div className="flex items-center gap-4 mb-10">
              <div className="w-14 h-14 bg-gradient-to-br from-indigo-600 to-blue-600 rounded-2xl flex items-center justify-center shadow-lg">
                <GraduationCap className="text-white" size={28} />
              </div>
              <h3 className="text-3xl font-bold text-gray-900 dark:text-white">Education</h3>
            </div>

            <div className="space-y-12">
              {experienceData.education.map((edu) => (
                <div
                  key={edu.id}
                  className="glass-card hover-lift p-8 rounded-[2rem] border-white/40 dark:border-gray-800/50 group"
                >
                  <h4 className="text-2xl font-bold text-gray-900 dark:text-white mb-2 group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors">
                    {edu.title}
                  </h4>
                  <div className="text-lg font-bold text-blue-600 dark:text-blue-400 mb-4 px-3 py-1 bg-blue-500/5 dark:bg-blue-400/5 rounded-lg inline-block">
                    {edu.institution}
                  </div>
                  
                  <div className="flex flex-wrap gap-4 text-sm font-semibold text-gray-500 dark:text-gray-400 mb-6">
                    <div className="flex items-center gap-2">
                      <MapPin size={16} className="text-blue-500" />
                      <span>{edu.location}</span>
                    </div>
                    <div className="flex items-center gap-2 text-indigo-500">
                      <Calendar size={16} />
                      <span>{new Date(edu.startDate).getFullYear()} - {new Date(edu.endDate).getFullYear()}</span>
                    </div>
                  </div>

                  <p className="text-gray-600 dark:text-gray-400 mb-6 leading-relaxed">{edu.description}</p>

                  <ul className="space-y-3">
                    {edu.highlights.map((highlight, idx) => (
                      <li key={idx} className="flex items-start gap-3 text-sm text-gray-600 dark:text-gray-400">
                        <span className="flex-shrink-0 w-1.5 h-1.5 rounded-full bg-blue-600 dark:bg-blue-400 mt-2"></span>
                        <span>{highlight}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
