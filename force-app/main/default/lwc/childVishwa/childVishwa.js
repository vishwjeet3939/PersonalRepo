import { LightningElement } from 'lwc';

export default class ChildVishwa extends LightningElement {

    name='';

    handleChange(event)
    {
        this.name = event.target.value;
        
    }
    
    handlesubmit(event){

        alert('inseide');
        const handleEvent = new CustomEvent('handlevalue', {detail: this.name});
        this.dispatchEvent(handleEvent);
    }
}