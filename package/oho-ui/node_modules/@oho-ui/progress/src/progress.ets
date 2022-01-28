export interface Progress {
  trackThickness: number
  trackColor: string
  indicatorColor: string
  indicatorDirection: number,
  initStroke: () => void
  initPath: () => void
  setActionTrigger: () => void
  resetActionTrigger: () => void
  switchMode: () => void
}

export interface CirProgress extends Progress {
  indicatorSize: number
  indicatorInset: number
}

export interface LineProgress extends Progress {
  indeterminateAnimationType: any
}

export const Style = {
  Line: 0,
  Cir: 1
}