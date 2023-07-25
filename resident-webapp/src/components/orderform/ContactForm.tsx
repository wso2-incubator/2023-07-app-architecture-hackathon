import * as React from 'react';
import Grid from '@mui/material/Grid';
import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';
import FormControlLabel from '@mui/material/FormControlLabel';
import Checkbox from '@mui/material/Checkbox';
import { Box, Button, FormControl, FormLabel, Radio, RadioGroup } from '@mui/material';
import { ContactProps } from './Props';

export default function ContactForm(props: ContactProps) {
  const [formData, setFormData] = React.useState({
    contactType: (props.contact.companyName === '') ? 'individual' : 'company',
    companyName: props.contact.companyName,
    firstName: props.contact.firstName,
    lastName: props.contact.lastName,
    tel: props.contact.tel,
    email: props.contact.email,
    address1: props.contact.address1,
    address2: props.contact.address2,
    city: props.contact.city,
    state: props.contact.state,
    zip: props.contact.zip,
    country: props.contact.country,
  });

  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = event.target;
    if (name === 'contactType' && value === 'individual') {
      setFormData((prevFormData) => ({
        ...prevFormData,
        [name]: value,
        companyName: ''
      }));
      return;
    }
    setFormData((prevFormData) => ({
      ...prevFormData,
      [name]: value
    }));
  };

  const handleNext = () => {
    props.setContact(formData);
    props.handleNext();
  };

  return (
    <React.Fragment>
      <Grid container spacing={3}>
        {/** option to pic individual or a company */}
        <Grid item xs={12}>
          <FormControl>
            <FormLabel id="contact-type">Contact</FormLabel>
            <RadioGroup
              row
              aria-labelledby="contact-type"
              name="contactType"
              value={formData.contactType}
              onChange={handleChange}
            >
              <FormControlLabel value="individual" control={<Radio />} label="Individual" />
              <FormControlLabel value="company" control={<Radio />} label="Company" />
            </RadioGroup>
          </FormControl>
        </Grid>
        {formData.contactType === 'company' && (
          <Grid item xs={12}>
            <TextField
              required
              id="companyName"
              name="companyName"
              label="Company name"
              fullWidth
              autoComplete="company-name"
              variant="standard"
              value={formData.companyName}
              onChange={handleChange}
            />
          </Grid>
        )}
        <Grid item xs={12} sm={6}>
          <TextField
            required
            id="firstName"
            name="firstName"
            label="First name"
            fullWidth
            autoComplete="given-name"
            variant="standard"
            value={formData.firstName}
            onChange={handleChange}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            required
            id="lastName"
            name="lastName"
            label="Last name"
            fullWidth
            autoComplete="family-name"
            variant="standard"
            value={formData.lastName}
            onChange={handleChange}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            required
            id="tel"
            name="tel"
            label="Telephone"
            fullWidth
            autoComplete="given-name"
            variant="standard"
            value={formData.tel}
            onChange={handleChange}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            required
            id="email"
            name="email"
            label="Email"
            fullWidth
            autoComplete="given-name"
            variant="standard"
            value={formData.email}
            onChange={handleChange}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            required
            id="address1"
            name="address1"
            label="Address line 1"
            fullWidth
            autoComplete="shipping address-line1"
            variant="standard"
            value={formData.address1}
            onChange={handleChange}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            id="address2"
            name="address2"
            label="Address line 2"
            fullWidth
            autoComplete="shipping address-line2"
            variant="standard"
            value={formData.address2}
            onChange={handleChange}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            required
            id="city"
            name="city"
            label="City"
            fullWidth
            autoComplete="shipping address-level2"
            variant="standard"
            value={formData.city}
            onChange={handleChange}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            id="state"
            name="state"
            label="State/Province/Region"
            fullWidth
            variant="standard"
            value={formData.state}
            onChange={handleChange}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            required
            id="zip"
            name="zip"
            label="Zip / Postal code"
            fullWidth
            autoComplete="shipping postal-code"
            variant="standard"
            value={formData.zip}
            onChange={handleChange}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            required
            id="country"
            name="country"
            label="Country"
            fullWidth
            autoComplete="shipping country"
            variant="standard"
            value={formData.country}
            onChange={handleChange}
          />
        </Grid>
        <Grid item xs={12}>
          <Box sx={{ mb: 2 }}>
            <div>
              <Button
                variant="contained"
                onClick={handleNext}
                sx={{ mt: 1, mr: 1 }}
              >
                Continue
              </Button>
              <Button
                onClick={props.handleBack}
                sx={{ mt: 1, mr: 1 }}
              >
                Back
              </Button>
            </div>
          </Box>
        </Grid>
      </Grid>
    </React.Fragment >
  );
}
