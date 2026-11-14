import type { SVGProps } from "react";
import type { SegmentKey } from "@/config/quiz.config";

/**
 * Ručno crtane ikonice, sve u istom stilu: 24×24, debela obla linija, bez ispune.
 * Dekorativne su (aria-hidden), tekst pored njih nosi značenje.
 */
type IconProps = SVGProps<SVGSVGElement> & { size?: number };

function Svg({ size = 24, strokeWidth = 2.3, children, ...rest }: IconProps) {
  return (
    <svg
      aria-hidden="true"
      width={size}
      height={size}
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth={strokeWidth}
      strokeLinecap="round"
      strokeLinejoin="round"
      {...rest}
    >
      {children}
    </svg>
  );
}

export const IconNota = (p: IconProps) => (
  <Svg {...p}>
    <path d="M9.2 17.6V5.4l9.6-2.1v11.9" />
    <ellipse cx="6.6" cy="17.8" rx="2.7" ry="2.2" transform="rotate(-14 6.6 17.8)" />
    <ellipse cx="16.2" cy="15.4" rx="2.7" ry="2.2" transform="rotate(-14 16.2 15.4)" />
  </Svg>
);

export const IconCena = (p: IconProps) => (
  <Svg {...p}>
    <path d="M3.4 12.6 11.7 4.1c.4-.4.9-.6 1.5-.6l5.6.2c.9 0 1.6.8 1.6 1.7l.1 5.5c0 .6-.2 1.1-.6 1.5l-8.4 8.4c-.7.7-1.8.7-2.5 0l-5.6-5.7c-.7-.7-.7-1.8 0-2.5Z" />
    <circle cx="16.1" cy="8" r="1.3" />
  </Svg>
);

export const IconLupa = (p: IconProps) => (
  <Svg {...p}>
    <path d="M10.5 4.1c3.5-.1 6.4 2.7 6.5 6.2.1 3.5-2.7 6.4-6.2 6.5-3.5.1-6.4-2.7-6.5-6.2-.1-3.5 2.7-6.4 6.2-6.5Z" />
    <path d="m15.4 15.3 5.2 5.4" />
    <path d="M7.6 9.6c.5-1.5 1.7-2.4 3.2-2.5" />
  </Svg>
);

export const IconKlapa = (p: IconProps) => (
  <Svg {...p}>
    <path d="M3.7 11.2h16.7v7.6c0 .9-.7 1.6-1.6 1.6H5.3c-.9 0-1.6-.7-1.6-1.6v-7.6Z" />
    <path d="M3.6 11.1 3 8.2l15.9-4.4.8 3.1L3.6 11.1Z" />
    <path d="m7.4 7 1.6 2.6M12 5.7l1.6 2.7M16.5 4.5l1.5 2.6" />
  </Svg>
);

export const IconJoker = (p: IconProps) => (
  <Svg {...p}>
    <path d="M12 2.9c5 0 9.2 4 9.1 9.1 0 5-4.1 9.1-9.2 9-5-.1-9-4.1-8.9-9.2C3.1 6.9 7 2.9 12 2.9Z" />
    <path d="M9.2 9.3c.2-1.7 1.5-2.8 3.1-2.7 1.6.1 2.8 1.2 2.7 2.7-.1 1.9-2.6 2.2-2.8 4.3" />
    <path d="M12.2 16.9h.01" />
  </Svg>
);

export const IconZvuk = (p: IconProps) => (
  <Svg {...p}>
    <path d="M4 9.6h3.3l4.6-3.9v12.7l-4.6-3.9H4.1Z" />
    <path d="M15.4 9.2c1.5 1.6 1.5 4.1 0 5.7M17.9 6.8c2.9 3 2.9 7.6 0 10.5" />
  </Svg>
);

export const IconBezZvuka = (p: IconProps) => (
  <Svg {...p}>
    <path d="M4 9.6h3.3l4.6-3.9v12.7l-4.6-3.9H4.1Z" />
    <path d="m15.6 9.4 5 5.3M20.7 9.5l-5.1 5.1" />
  </Svg>
);

export const IconStrelica = (p: IconProps) => (
  <Svg strokeWidth={2.8} {...p}>
    <path d="M5 12.1h13.6M13.2 6.6l5.6 5.5-5.6 5.4" />
  </Svg>
);

export const IconNazad = (p: IconProps) => (
  <Svg strokeWidth={2.8} {...p}>
    <path d="M19 12.1H5.4M10.8 6.6l-5.6 5.5 5.6 5.4" />
  </Svg>
);

export const IconPismo = (p: IconProps) => (
  <Svg {...p}>
    <path d="M3.4 6.9c0-.8.7-1.5 1.5-1.5h14.3c.8 0 1.4.7 1.4 1.5v10.3c0 .8-.6 1.5-1.4 1.5H4.9c-.8 0-1.5-.7-1.5-1.5V6.9Z" />
    <path d="m4.2 7.4 7.9 6 7.8-6.1" />
  </Svg>
);

export const IconVatra = (p: IconProps) => (
  <Svg {...p}>
    <path d="M12.2 3.1c.6 3.2 5.4 5.200 5.300 10.400-.1 3.900-2.700 6.600-5.700 6.500-3-.1-5.400-2.600-5.300-6 .1-2 1-3.400 2.200-4.700.2 1.500.9 2.500 1.900 3 .2-3.200.2-6.300 1.600-9.200Z" />
    <path d="M12 20c-1.400-.1-2.400-1.200-2.300-2.700.1-1.300 1.100-2.200 2.300-3.300 1 1.100 2.100 2 2.100 3.400 0 1.500-.9 2.600-2.100 2.600Z" />
  </Svg>
);

export const IconStikla = (p: IconProps) => (
  <Svg strokeWidth={2.8} {...p}>
    <path d="m4.800 12.700 4.700 4.800L19.400 6.900" />
  </Svg>
);

export const IconSat = (p: IconProps) => (
  <Svg {...p}>
    <path d="M12 4.100c4.400 0 8 3.600 7.900 8-.1 4.400-3.600 7.900-8 7.800-4.400-.1-7.800-3.600-7.800-8 .1-4.300 3.600-7.800 7.900-7.800Z" />
    <path d="M12 7.900v4.400l2.900 1.900" />
  </Svg>
);

export const IconKruna = (p: IconProps) => (
  <Svg {...p}>
    <path d="M3.6 8.3 6 17.4c.1.5.6.9 1.2.9h9.7c.6 0 1.1-.4 1.2-.9l2.3-9.2-4.9 3.4L12 5.2 8.5 11.7 3.6 8.3Z" />
    <path d="M7.3 21h9.5" />
  </Svg>
);

export const IconZvezda = (p: IconProps) => (
  <Svg {...p}>
    <path d="m12.1 3.3 2.5 5.4 5.9.7c.4.1.6.6.3.9l-4.4 4 1.2 5.8c.1.4-.4.8-.8.6L12 17.8l-5 2.9c-.4.2-.9-.1-.8-.6l1.2-5.8-4.3-4c-.3-.3-.2-.8.3-.9l5.9-.7 2.4-5.4c.1-.4.3-.4.4 0Z" />
  </Svg>
);

export function SegmentIcon({ segment, size = 26 }: { segment: SegmentKey; size?: number }) {
  switch (segment) {
    case "pesma":
      return <IconNota size={size} />;
    case "cena":
      return <IconCena size={size} />;
    case "gugla":
      return <IconLupa size={size} />;
    case "film":
      return <IconKlapa size={size} />;
    case "rebus":
      return <IconJoker size={size} />;
  }
}
