
export interface Contact {
    companyName: string
    firstName: string,
    lastName: string,
    address1: string,
    address2: string,
    city: string,
    state: string,
    zip: string,
    country: string,
    tel: string,
    email: string,
}
export interface Order {
    orderId?: string,
    shipper: Contact,
    receiver: Contact,
    productDescription: string,
    product: string,
    actualWeight: string,
    noOfPackages: string,
    length: string,
    width: string,
    height: string,
    customsValue: string,
    billShippingCharges: string,
    billDutyTaxes: string,
    serviceLevel: string,
    specialInstructions: string,
    orderReferences: string
}
