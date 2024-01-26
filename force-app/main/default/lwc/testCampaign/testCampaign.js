import { LightningElement, wire } from 'lwc';
import getCampaignOptions from '@salesforce/apex/CampaignController.getCampaignOptions';

export default class TestCampaign extends LightningElement {
    campaignOptions = [];
    selectedCampaigns = [];

    @wire(getCampaignOptions)
    wiredCampaignOptions({ data, error }) {
        if (data) {
            this.campaignOptions = data.map(option => ({ label: option.Name, value: option.Id }));
        } else if (error) {
            // Handle error
        }
    }

    handleCampaignSelection(event) {
        this.selectedCampaigns = event.detail.value;
    }

    getSelectedCampaigns() {
        return this.selectedCampaigns;
    }
}