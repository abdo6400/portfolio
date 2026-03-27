import { Smartphone, Server, Wrench, Palette } from 'lucide-react';
import skillsData from '../../imports/skills.json';

export function Skills() {
  const iconMap: Record<string, any> = {
    mobile: Smartphone,
    server: Server,
    tools: Wrench,
    flutter: Palette,
  };

  return (
    <section id="skills" className="py-20 bg-gray-50 dark:bg-gray-900">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-16">
          <h2 className="text-4xl sm:text-5xl mb-4 text-gray-900 dark:text-white">
            Skills & Expertise
          </h2>
          <div className="w-20 h-1 bg-gradient-to-r from-blue-600 to-indigo-600 mx-auto rounded-full"></div>
        </div>

        <div className="grid md:grid-cols-2 gap-8">
          {skillsData.map((category, idx) => {
            const Icon = iconMap[category.icon] || Server;
            return (
              <div
                key={idx}
                className="bg-white dark:bg-gray-950 rounded-xl p-8 shadow-md dark:shadow-blue-900/10 hover:shadow-xl dark:hover:shadow-blue-900/20 transition-all border border-transparent dark:border-gray-800"
              >
                <div className="flex items-center gap-3 mb-6">
                  <div className="w-12 h-12 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-lg flex items-center justify-center shadow-lg">
                    <Icon className="text-white" size={24} />
                  </div>
                  <h3 className="text-2xl text-gray-900 dark:text-white">
                    {category.category}
                  </h3>
                </div>

                <div className="flex flex-wrap gap-3">
                  {category.skills.map((skill, skillIdx) => (
                    <span
                      key={skillIdx}
                      className="px-4 py-2 bg-gradient-to-r from-blue-50 to-indigo-50 dark:from-gray-900 dark:to-blue-950 text-gray-700 dark:text-gray-300 rounded-lg border border-blue-100 dark:border-gray-800 hover:scale-105 transition-transform cursor-default"
                    >
                      {skill.name}
                    </span>
                  ))}
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
