import { LightningElement } from 'lwc';

export default class ParentVishwa extends LightningElement {


    name='';

    handleEvent(event){

        this.name = event.detail;
    }
}