import type {Config} from '@docusaurus/types';
import type {Options, ThemeConfig} from '@docusaurus/preset-classic';
import {themes as prismThemes} from 'prism-react-renderer';

const config: Config = {
  title: 'Portable Agent',
  tagline: 'A portable personal AI agent that turns intent into safe action',
  url: 'https://danliaqwerty20.github.io',
  baseUrl: '/portable-agent-platform/',
  organizationName: 'DanliaQwerty20',
  projectName: 'portable-agent-platform',
  onBrokenLinks: 'throw',
  markdown: {
    mermaid: true,
    hooks: {
      onBrokenMarkdownLinks: 'throw',
    },
  },
  themes: ['@docusaurus/theme-mermaid'],
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },
  presets: [
    [
      'classic',
      {
        docs: {
          path: '../docs',
          routeBasePath: '/',
          sidebarPath: './sidebars.ts',
          editUrl: ({docPath}) =>
            `https://github.com/DanliaQwerty20/portable-agent-platform/edit/main/docs/${docPath}`,
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Options,
    ],
  ],
  themeConfig: {
    navbar: {
      title: 'Portable Agent',
      items: [
        {to: '/architecture/PLATFORM', label: 'Architecture', position: 'left'},
        {to: '/delivery/ROADMAP', label: 'Roadmap', position: 'left'},
        {
          href: 'https://github.com/DanliaQwerty20/portable-agent-platform',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      copyright: `Copyright © ${new Date().getFullYear()} Portable Agent contributors. Apache-2.0.`,
    },
    mermaid: {
      theme: {light: 'neutral', dark: 'dark'},
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
  } satisfies ThemeConfig,
};

export default config;
