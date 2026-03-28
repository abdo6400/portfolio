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
    <section id="skills" className="py-24 bg-white dark:bg-gray-950 relative overflow-hidden">
      {/* Decorative Background Elements */}
      <div className="absolute top-1/2 -right-20 w-80 h-80 bg-blue-500/5 rounded-full blur-[100px]"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="text-center mb-16">
          <h2 className="text-4xl sm:text-6xl font-black mb-4 text-gray-900 dark:text-white tracking-tight">
            <span className="text-gradient">Skills & Expertise</span>
          </h2>
          <div className="w-24 h-1.5 bg-gradient-to-r from-blue-600 to-indigo-600 mx-auto rounded-full shadow-sm"></div>
        </div>

        <div className="grid md:grid-cols-2 gap-10">
          {skillsData.map((category, idx) => {
            const Icon = iconMap[category.icon] || Server;
            return (
              <div
                key={idx}
                className="glass-card hover-lift rounded-[2.5rem] p-10 border-white/40 dark:border-gray-800/50 group"
              >
                <div className="flex items-center gap-5 mb-8">
                  <div className="w-16 h-16 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-[1.25rem] flex items-center justify-center shadow-lg group-hover:scale-110 transition-transform duration-300">
                    <Icon className="text-white" size={32} />
                  </div>
                  <h3 className="text-3xl font-bold text-gray-900 dark:text-white">
                    {category.category}
                  </h3>
                </div>

                <div className="flex flex-wrap gap-3">
                  {category.skills.map((skill, skillIdx) => (
                    <span
                      key={skillIdx}
                      className="px-5 py-2.5 glass-card rounded-2xl text-gray-700 dark:text-gray-300 font-semibold text-sm hover:bg-blue-600 hover:text-white dark:hover:bg-blue-500 transition-all cursor-default shadow-sm border-white/50"
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
