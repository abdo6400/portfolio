import { Briefcase, GraduationCap, MapPin, Calendar } from 'lucide-react';
import experienceData from '../../imports/experience.json';

export function Experience() {
  return (
    <section id="experience" className="py-20 bg-white dark:bg-gray-950">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-16">
          <h2 className="text-4xl sm:text-5xl mb-4 text-gray-900 dark:text-white">
            Experience & Education
          </h2>
          <div className="w-20 h-1 bg-gradient-to-r from-blue-600 to-indigo-600 mx-auto rounded-full"></div>
        </div>

        <div className="grid lg:grid-cols-2 gap-12">
          {/* Work Experience */}
          <div>
            <div className="flex items-center gap-3 mb-8">
              <div className="w-10 h-10 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-lg flex items-center justify-center shadow-lg">
                <Briefcase className="text-white" size={20} />
              </div>
              <h3 className="text-2xl text-gray-900 dark:text-white">Work Experience</h3>
            </div>

            <div className="space-y-8">
              {experienceData.experience.map((exp) => (
                <div
                  key={exp.id}
                  className="relative pl-8 pb-8 border-l-2 border-blue-200 dark:border-blue-900 last:border-l-0 last:pb-0"
                >
                  <div className="absolute -left-2 top-0 w-4 h-4 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-full shadow-lg"></div>
                  
                  <div className="bg-gradient-to-br from-blue-50 to-indigo-50 dark:from-gray-900 dark:to-blue-950 p-6 rounded-xl border border-blue-100 dark:border-gray-800 hover:shadow-lg dark:hover:shadow-blue-900/20 transition-all">
                    <h4 className="text-xl text-gray-900 dark:text-white mb-2">
                      {exp.title}
                    </h4>
                    <div className="text-blue-600 dark:text-blue-400 mb-2">
                      {exp.company}
                    </div>
                    
                    <div className="flex flex-wrap gap-4 text-sm text-gray-600 dark:text-gray-400 mb-4">
                      <div className="flex items-center gap-1">
                        <MapPin size={14} />
                        <span>{exp.location}</span>
                      </div>
                      <div className="flex items-center gap-1">
                        <Calendar size={14} />
                        <span>{exp.startDate} - {exp.endDate}</span>
                      </div>
                    </div>

                    <p className="text-gray-700 dark:text-gray-300 mb-4">{exp.description}</p>

                    <ul className="space-y-2">
                      {exp.highlights.map((highlight, idx) => (
                        <li key={idx} className="flex items-start gap-2 text-gray-600 dark:text-gray-400">
                          <span className="text-blue-600 dark:text-blue-400 mt-1">•</span>
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
          <div>
            <div className="flex items-center gap-3 mb-8">
              <div className="w-10 h-10 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-lg flex items-center justify-center shadow-lg">
                <GraduationCap className="text-white" size={20} />
              </div>
              <h3 className="text-2xl text-gray-900 dark:text-white">Education</h3>
            </div>

            <div className="space-y-8">
              {experienceData.education.map((edu) => (
                <div
                  key={edu.id}
                  className="bg-gradient-to-br from-blue-50 to-indigo-50 dark:from-gray-900 dark:to-blue-950 p-6 rounded-xl border border-blue-100 dark:border-gray-800 hover:shadow-lg dark:hover:shadow-blue-900/20 transition-all"
                >
                  <h4 className="text-xl text-gray-900 dark:text-white mb-2">
                    {edu.title}
                  </h4>
                  <div className="text-blue-600 dark:text-blue-400 mb-2">
                    {edu.institution}
                  </div>
                  
                  <div className="flex flex-wrap gap-4 text-sm text-gray-600 dark:text-gray-400 mb-4">
                    <div className="flex items-center gap-1">
                      <MapPin size={14} />
                      <span>{edu.location}</span>
                    </div>
                    <div className="flex items-center gap-1">
                      <Calendar size={14} />
                      <span>{new Date(edu.startDate).getFullYear()} - {new Date(edu.endDate).getFullYear()}</span>
                    </div>
                  </div>

                  <p className="text-gray-700 dark:text-gray-300 mb-4">{edu.description}</p>

                  <ul className="space-y-2">
                    {edu.highlights.map((highlight, idx) => (
                      <li key={idx} className="flex items-start gap-2 text-gray-600 dark:text-gray-400">
                        <span className="text-blue-600 dark:text-blue-400 mt-1">•</span>
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
