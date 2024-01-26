import { LightningElement ,track} from 'lwc';

export default class ContactTable extends LightningElement {

    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track phone = '';
    @track addedInfo = '';

    handleChange(event) {
        const fieldName = event.target.name;
        const fieldValue = event.target.value;

        
        if (fieldName === 'firstName') {
            this.firstName = fieldValue;
        } else if (fieldName === 'lastName') {
            this.lastName = fieldValue;
        } else if (fieldName === 'email') {
            this.email = fieldValue;
        } else if (fieldName === 'phone') {
            this.phone = fieldValue;
        }
    }

    handleAdd() {
        this.addedInfo = `Added Information: 
            First Name: ${this.firstName}
            Last Name: ${this.lastName}
            Email: ${this.email}
            Phone: ${this.phone}`;
    }
}