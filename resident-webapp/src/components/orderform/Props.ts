
import { Order, Contact } from "../../types/domain";

export interface StepProps {
    handleNext: () => void;
    handleBack: () => void;
    setOrder: (order: Order) => void;
    order: Order;
}

export interface ContactProps {
    handleNext: () => void;
    handleBack: () => void;
    setContact: (contact: Contact) => void;
    contact: Contact;
}