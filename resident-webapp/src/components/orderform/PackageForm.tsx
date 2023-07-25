import * as React from 'react';
import Grid from '@mui/material/Grid';
import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';
import FormControlLabel from '@mui/material/FormControlLabel';
import Checkbox from '@mui/material/Checkbox';
import { Box, Button, FormControl, Radio, RadioGroup } from '@mui/material';
import { useState } from 'react';
import { StepProps } from './Props';

export default function PackageForm(props: StepProps) {

    const [formValues, setFormValues] = useState({
        productDescription: props.order.productDescription,
        product: props.order.product,
        actualWeight: props.order.actualWeight,
        noOfPackages: props.order.noOfPackages,
        length: props.order.length,
        width: props.order.width,
        height: props.order.height,
        customsValue: props.order.customsValue
    });

    const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setFormValues({ ...formValues, [event.target.name]: event.target.value });
    };

    const handleNext = () => {
        props.setOrder({
            ...props.order,
            productDescription: formValues.productDescription,
            product: formValues.product,
            actualWeight: formValues.actualWeight,
            noOfPackages: formValues.noOfPackages,
            length: formValues.length,
            width: formValues.width,
            height: formValues.height,
            customsValue: formValues.customsValue
        });
        props.handleNext();
    };

    return (
        <React.Fragment>
            <Grid container spacing={3}>
                <Grid item xs={12}>
                    <TextField
                        id="productDescription"
                        name="productDescription"
                        label="Description of goods"
                        multiline
                        rows={2}
                        maxRows={4}
                        fullWidth
                        variant="standard"
                        value={formValues.productDescription}
                        onChange={handleChange}
                    />
                </Grid>
                <Grid item xs={12}>
                    <Typography gutterBottom>Product</Typography>
                    <FormControl component="fieldset">
                        <RadioGroup
                            aria-label="product"
                            name="product"
                            row
                            value={formValues.product}
                            onChange={handleChange}
                        >
                            <FormControlLabel
                                value="document"
                                control={<Radio />}
                                label="Document"
                            />
                            <FormControlLabel
                                value="non-document"
                                control={<Radio />}
                                label="Non-Document"
                            />
                        </RadioGroup>
                    </FormControl>
                </Grid>
                <Grid item xs={12} sm={6}>
                    <TextField
                        required
                        id="actualWeight"
                        name="actualWeight"
                        label="Actual Weight"
                        fullWidth
                        autoComplete="family-name"
                        variant="standard"
                        value={formValues.actualWeight}
                        onChange={handleChange}
                    />
                </Grid>
                <Grid item xs={12} sm={6}>
                    <TextField
                        required
                        id="noOfPackages"
                        name="noOfPackages"
                        label="No. of Packages"
                        fullWidth
                        autoComplete="1"
                        variant="standard"
                        value={formValues.noOfPackages}
                        onChange={handleChange}
                    />
                </Grid>
                <Grid item xs={12}>
                    <Grid container spacing={2}>
                        <Grid item xs={4}>
                            <TextField
                                id="length"
                                name="length"
                                label="Length"
                                variant="standard"
                                value={formValues.length}
                                onChange={handleChange}
                            />
                        </Grid>
                        <Grid item xs={4}>
                            <TextField
                                id="width"
                                name="width"
                                label="Width"
                                variant="standard"
                                value={formValues.width}
                                onChange={handleChange}
                            />
                        </Grid>
                        <Grid item xs={4}>
                            <TextField
                                id="height"
                                name="height"
                                label="Height"
                                variant="standard"
                                value={formValues.height}
                                onChange={handleChange}
                            />
                        </Grid>
                    </Grid>
                </Grid>
                <Grid item xs={12} sm={6}>
                    <TextField
                        required
                        id="customsValue"
                        name="customsValue"
                        label="Customs Value"
                        fullWidth
                        autoComplete="0"
                        variant="standard"
                        value={formValues.customsValue}
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
