import { LightningElement } from 'lwc';

export default class LoopingDemo extends LightningElement {
    contacts = [
	{
	recordId : "100",
	fname:'Ankit',
	lname : 'jain',
	email : 'ankitjain@test.com'
	},
	{
	recordId : "102",
	fname:'Amit',
	lname : 'Salunke',
	email : 'ankitSalunke@test.com'
	},
	{
	recordId : "103",
	fname:'John',
	lname : 'Kelly',
	email : 'jonkelly@test.com'
	}
]
}