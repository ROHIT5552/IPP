import { GesHousehold } from '../../types/api';

const KEY = 'newra.household';

export const householdStore = {
  read(): GesHousehold | null {
    if (typeof window === 'undefined') return null;
    try {
      const value = JSON.parse(window.localStorage.getItem(KEY) || 'null') as GesHousehold | null;
      if (!value?.profiles?.length) return null;
      return value;
    } catch {
      return null;
    }
  },
  save(value: GesHousehold) {
    window.localStorage.setItem(KEY, JSON.stringify(value));
  },
  clear() {
    window.localStorage.removeItem(KEY);
  },
};
