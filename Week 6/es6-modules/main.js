import {sayHello, sayGoodBye} from './modules/functions.js'
import {Person} from './modules/class.js'
import doIt from './modules/function.js'

doIt();

const p = new Person("Lu");
p.sayHello();

sayHello();
sayGoodBye();