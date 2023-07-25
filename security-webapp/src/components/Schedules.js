import React, { useState, useEffect } from 'react';
import { Container, Input} from 'semantic-ui-react';
import { useAuthContext } from "@asgardeo/auth-react";
// import UnderConstructionMessage from './UnderConstructionMessage';
import { Table, Header, HeaderCell, HeaderRow, Body, Row, Cell } from '@table-library/react-table-library/table';

function Schedules() {

  // const [items, setitems] = useState([]);
  // const [searchTerm, setSearchTerm] = useState('');
  // const [searchResults, setSearchResults] = useState([]);
  const baseUrl = process.env.REACT_APP_RESOURCE_SERVER_URL;
  const [search, setSearch] = useState('');
  const handleSearch = (event) => {
    setSearch(event.target.value);
  };

  const { state, httpRequest } = useAuthContext();
  var path = "/items";
  var isAttachToken = false;
  var isWithCredentials = false;

  const requestConfig = {
    headers: {
      "Access-Control-Allow-Origin": "*"
    },
    method: "GET",
    url: baseUrl + path,
    attachToken: isAttachToken,
    withCredentials: isWithCredentials
  };

  useEffect(() => {
    // call API
    // async function fetchitems() {
    //   console.log('baseUrl', baseUrl);
    //   const response = await httpRequest(requestConfig);
    //   console.log(response.data);
    //   setitems(response.data);
    // }

    // fetchitems();


  }, []);

  let mockResults = [
    { "houseNo": "1", "visitorName": "Mark", "visitorNIC": "1234", "visitorPhoneNo": "123-456-7890", "vehicleNumber": "wp-1234", "visitDate": "7/28/2023", "isApproved": true, "comment": "desc", "visitId": 1 },
    { "houseNo": "2", "visitorName": "John", "visitorNIC": "5678", "visitorPhoneNo": "123-456-7890", "vehicleNumber": "wp-1234", "visitDate": "7/29/2023", "isApproved": true, "comment": "desc", "visitId": 2 },
    { "houseNo": "3", "visitorName": "Mary", "visitorNIC": "1234", "visitorPhoneNo": "123-444-7890", "vehicleNumber": "wp-1234", "visitDate": "7/29/2023", "isApproved": true, "comment": "desc", "visitId": 3 },
    { "houseNo": "4", "visitorName": "Ann", "visitorNIC": "1234", "visitorPhoneNo": "123-555-7890", "vehicleNumber": "wp-1234", "visitDate": "7/30/2023", "isApproved": true, "comment": "desc", "visitId": 4 },
    { "houseNo": "5", "visitorName": "Bob", "visitorNIC": "1234", "visitorPhoneNo": "777-456-7890", "vehicleNumber": "wp-1234", "visitDate": "7/28/2023", "isApproved": true, "comment": "desc", "visitId": 5 }
  ];

  const data = {
    nodes: mockResults.filter((item) =>
      item.visitorName.toLowerCase().includes(search.toLowerCase()) ||
      item.visitorNIC.includes(search) ||
      item.visitorPhoneNo.includes(search) ||
      item.vehicleNumber.includes(search)
    ),
  };

  return (
    <Container>
      <label htmlFor="search">
        Search by Task:
        <input id="search" type="text" onChange={handleSearch} />
      </label>
      <Table data={data}>
        {(tableList) => (
        <>
          <Header>
            <HeaderRow>
              <HeaderCell>House #</HeaderCell>
              <HeaderCell>Visitor Name</HeaderCell>
              <HeaderCell>NIC</HeaderCell>
              <HeaderCell>Phone #</HeaderCell>
              <HeaderCell>Vehicle #</HeaderCell>
              <HeaderCell>Visit Date</HeaderCell>
              <HeaderCell>Approved</HeaderCell>
              <HeaderCell>Comment</HeaderCell>
              <HeaderCell>Visit Id</HeaderCell>
            </HeaderRow>
          </Header>
          <Body>
            {tableList.map((item) => (
              <Row key={item.houseNo} item={item}>
                <Cell>{item.houseNo}</Cell>
                <Cell>{item.visitorName}</Cell>
                <Cell>{item.visitorNIC}</Cell>
                <Cell>{item.visitorPhoneNo}</Cell>
                <Cell>{item.vehicleNumber}</Cell>
                <Cell>{item.visitDate}</Cell>
                <Cell>{item.isApproved}</Cell>
                <Cell>{item.comment}</Cell>
                <Cell>{item.visitId}</Cell>
              </Row>
            ))}
          </Body>
        </>
        )}
    </Table>
    </Container>
  );
}

export default Schedules;
