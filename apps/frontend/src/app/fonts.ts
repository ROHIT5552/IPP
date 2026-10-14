import { Instrument_Sans, Urbanist } from 'next/font/google';
import localFont from 'next/font/local';

export const instrument = Instrument_Sans({
  subsets: ['latin'],
  weight: ['400', '500', '600', '700'],
  display: 'swap',
  variable: '--font-instrument',
});

export const urbanist = Urbanist({
  subsets: ['latin'],
  weight: ['500', '600', '700'],
  display: 'swap',
  variable: '--font-urbanist',
});

export const glonto = localFont({
  src: '../../public/fonts/Glonto-Regular.ttf',
  weight: '400',
  style: 'normal',
  display: 'swap',
  variable: '--font-glonto',
});

export const fontVariables = `${instrument.variable} ${urbanist.variable} ${glonto.variable}`;
