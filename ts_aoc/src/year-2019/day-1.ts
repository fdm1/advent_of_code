// import { getInput } from '../util'
import { getInput } from '@src/util'


export const getFuel = (mass: number): number => {


    return Math.floor(mass / 3   )
}

const input = getInput(2019, 1)
const part1 = input.split('\n')
    .map((n: string) => {return parseInt(n)})
    .map((mass: number) => {return getFuel(mass)})
    .reduce((sum: number, current: number) => sum + current, 0);

console.log(`part1: ${part1}`)