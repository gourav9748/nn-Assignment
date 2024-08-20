/**
* Name            :    Country_Information
* Description     :    This is the Js file of Country_Information
* Created Date    :    [19th Aug, 2024]
* Created By      :    [Gourav Bhowmik] 
*
*/

import { LightningElement, api } from 'lwc';
import getCountryInfo from '@salesforce/apex/CountryInfoHandler.getCountry';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
import { refreshApex } from '@salesforce/apex';   

const EVENTS = {
    country_information_event: 'country_information_event',
    REFRESH_COUNTRY_INFORMATION: 'REFRESH_COUNTRY_INFORMATION'
};                                          

export default class Country_Information extends LightningElement {

    countryId;
    @api recordId;
    channelName = '/data/LeadChangeEvent';
    subscription = {}; // holds subscription, used for unsubscribe

    connectedCallback() {
        this.registerErrorListener();
        this.registerSubscribe();
        this.getcountryDetails();
        
    }
    // get the coutry id
    getcountryDetails(){
        getCountryInfo({ 
            leadId : this.recordId
        }).then(result => {
                this.countryId = result.Id;
            })
            .catch(error => {
                this.error = error;
            });

    }

    disconnectedCallback() {
        unsubscribe(this.subscription, () => console.log('Unsubscribed to change events.'));
    }

    // Called by connectedCallback()
    registerErrorListener() {
        onError(error => {
        console.error('Salesforce error', JSON.stringify(error));
        });
    }

    // Called by connectedCallback()
    registerSubscribe() {
        const changeEventCallback = changeEvent => {
        this.processChangeEvent(changeEvent);
        };

        // Sets up subscription and callback for change events
        subscribe(this.channelName, -1, changeEventCallback).then(subscription => {
        this.subscription = subscription;
        });
    }

    // Called by registerSubscribe()
    processChangeEvent(changeEvent) {
        try {
        const recordIds = changeEvent.data.payload.ChangeEventHeader.recordIds; // avoid deconstruction
            if (recordIds.includes(this.recordId)) {
                refreshApex(this.getcountryDetails()); // Refresh all components
            }
        } catch (err) {
        console.error(err);
        }
    }
}