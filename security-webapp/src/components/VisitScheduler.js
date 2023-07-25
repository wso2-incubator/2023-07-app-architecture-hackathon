import React, { useState } from 'react';
import { Container, Button, Form, Modal } from 'semantic-ui-react';
import { useAuthContext } from "@asgardeo/auth-react";

const VisitScheduler = ({ onScheduleVisit }) => {
  const { state, httpRequest } = useAuthContext();
  const [showModal, setShowModal] = useState(false);

  const [formData, setFormData] = useState({
    houseNo: '',
    visitorName: '',
    visitorNIC: '',
    visitorPhoneNo: '',
    vehicleNumber: '',
    visitorPhoneNo: '',
    visitDate: '',
    isApproved: false,
    comment: '',
  });

  const scheduleVisit = () => {
    setShowModal(true);
  };

  const handleSubmit = () => {
    // Handle form submission here (e.g., send data to backend or perform any necessary action)
    console.log(formData);
    handleAddItemSubmit();
    // You can add your logic to save the data or send it to the server.
    // For this example, we will just log the form data.
    setShowModal(false);
  };


  const handleAddItemSubmit = async () => {
    formData.visitDate = formData.visitDate + ":00.00Z";
    const requestConfig = {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*,http://localhost:3000"
      },
      method: "POST",
      url: window.config.resourceServerURL + '/scheduledVisits',
      data: formData,
      withCredentials: false
    };

    httpRequest(requestConfig)
      .then((response) => {
        console.log(response);
      })
      .catch((error) => {
        console.error(error);
      });
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    //if the input field name is visitDate
    // if (name === "visitDate") {
    //   var formattedValue = value + ":00.00Z";
    //   setFormData({
    //     ...formData,
    //     [name]: formattedValue,
    //   });
    // } else {
    //   setFormData({
    //     ...formData,
    //     [name]: value,
    //   });
    // }

    setFormData({
      ...formData,
      [name]: value,
    });
  };

  const closeModal = () => {
    setShowModal(false);
  };

  return (
    <Container style={{ marginTop: '2rem' }}>
      <Modal
        open={showModal}
        onClose={closeModal}
        trigger={
          <Button primary onClick={scheduleVisit} size="huge">
            Schedule a new Visit
          </Button>
        }
      >
        <Modal.Header>Schedule a New Visit</Modal.Header>
        <Modal.Content>
          <Form onSubmit={handleSubmit}>
            <Form.Field>
              <label>House ID</label>
              <input
                type="text"
                name="houseNo"
                placeholder="House ID"
                value={formData.houseNo}
                onChange={handleChange}
                required
              />
            </Form.Field>
            <Form.Field>
              <label>Visitor Name</label>
              <input
                type="text"
                name="visitorName"
                placeholder="Visitor Name"
                value={formData.visitorName}
                onChange={handleChange}
                required
              />
            </Form.Field>
            <Form.Field>
              <label>Visitor NIC</label>
              <input
                type="text"
                name="visitorNIC"
                placeholder="Visitor NIC"
                value={formData.visitorNIC}
                onChange={handleChange}
                required
              />
            </Form.Field>
            <Form.Field>
              <label>Visitor Phone</label>
              <input
                type="text"
                name="visitorPhoneNo"
                placeholder="Visitor Phone"
                value={formData.visitorPhoneNo}
                onChange={handleChange}
                required
              />
            </Form.Field>
            <Form.Field>
              <label>Visitor Vehicle Number</label>
              <input
                type="text"
                name="vehicleNumber"
                placeholder="Visitor Vehicle Number"
                value={formData.vehicleNumber}
                onChange={handleChange}
                required
              />
            </Form.Field>
            <Form.Field>
              <label>Visit Date and Time</label>
              <input
                type="datetime-local"
                name="visitDate"
                value={formData.visitDate}
                onChange={handleChange}
                required
              />
            </Form.Field>
            <Form.Field>
              <label>Comment</label>
              <input
                type="text"
                name="comment"
                placeholder="Visitor Vehicle Number"
                value={formData.comment}
                onChange={handleChange}
                required
              />
            </Form.Field>
            <Button type="submit" positive>
              Submit
            </Button>
          </Form>
        </Modal.Content>
      </Modal>
    </Container>
  );
};

export default VisitScheduler;
