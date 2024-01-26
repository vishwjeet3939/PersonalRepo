// contactForm.js
import { LightningElement, track, api } from 'lwc';

export default class bulkContact extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track phone = '';
    @track contacts = [];

    handleInputChange(event) {
        const { name, value } = event.target;
        this[name] = value;
    }

    handleAddClick() {
        if (this.firstName && this.lastName && this.email && this.phone) {
            const newContact = {
                id: this.contacts.length + 1,
                firstName: this.firstName,
                lastName: this.lastName,
                email: this.email,
                phone: this.phone
            };

            this.contacts = [...this.contacts, newContact];

            // Clear input fields
            this.firstName = '';
            this.lastName = '';
            this.email = '';
            this.phone = '';
        }
    }

    async handleSubmitClick() {
        if (this.contacts.length > 0) {
            // Call an Apex method to create contacts
            try {
                const result = await this.createContacts({ contacts: this.contacts });
                console.log('Contacts created successfully:', result);
                
                // Optionally, clear the contact list after successful submission
                this.contacts = [];
            } catch (error) {
                console.error('Error creating contacts:', error);
            }
        }
    }

    @api
    createContacts(data) {
        // Simulate Apex method to create contact records
        return new Promise((resolve, reject) => {
            // In a real scenario, make a server-side Apex call here
            // Example: YourApexClass.createContacts(data)
            // Simulating a successful response for demonstration purposes
            setTimeout(() => {
                resolve('Success');
            }, 1000);
        });
    }
}