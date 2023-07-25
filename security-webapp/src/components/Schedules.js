import React, { useState, useEffect } from 'react';
import { Container } from 'semantic-ui-react';
import { useAuthContext } from "@asgardeo/auth-react";
// import UnderConstructionMessage from './UnderConstructionMessage';
// import UnderConstructionMessage from './UnderConstructionMessage';
import SecurityStaffWelcome from './SecurityStaffWelcome';
import { Table, Header, HeaderCell, HeaderRow, Body, Row, Cell } from '@table-library/react-table-library/table';
import { useTheme } from '@table-library/react-table-library/theme';
import { getTheme } from '@table-library/react-table-library/baseline';
import VisitScheduler from './VisitScheduler';


function Schedules() {

  const scheduleVisit = () => {
    console.log("Visit scheduled!"); // You can add your scheduling logic here
  };

  // const [items, setitems] = useState([]);
  // const [searchTerm, setSearchTerm] = useState('');
  // const [searchResults, setSearchResults] = useState([]);
  // const baseUrl = process.env.REACT_APP_RESOURCE_SERVER_URL;
  const scheduledVisitURL = window.config.scheduledVisitURL;
  const [searchResults, setSearchResults] = useState([]);
  const [search, setSearch] = useState('');
  const handleSearch = (event) => {
    setSearch(event.target.value);
  };

  const theme = useTheme(getTheme());

  const { state, httpRequest } = useAuthContext();
  // var path = "/items";
  var isWithCredentials = false;

  const requestConfig = {
    headers: {
      "Access-Control-Allow-Origin": "*"
    },
    method: "GET",
    url: scheduledVisitURL + "/scheduledVisits",
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

    if (state.isAuthenticated) {

      httpRequest(requestConfig)
        .then((response) => {
          setSearchResults(response.data);
        })
        .catch((error) => {
          console.error(error);
        });
    }

  }, []);

  const data = {
    nodes: searchResults.filter((item) =>      
      (item?.visitorName?.toLowerCase().includes(search.toLowerCase())) 
    ),
  };

  if(state.isAuthenticated) {
    return (
      <Container>
        <div class="ui input">
            <input type="text" placeholder="Search..." onChange={handleSearch} />
        </div>
        <VisitScheduler onScheduleVisit={scheduleVisit} />

             <Table data={data} theme={theme}>
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
               <Row key={item.houseNo}>
                 <Cell data-label="houseNo">{item.houseNo}</Cell>
                 <Cell data-label="visitorName">{item.visitorName}</Cell>
                 <Cell data-label="visitorNIC">{item.visitorNIC}</Cell>
                 <Cell data-label="visitorPhoneNo">{item.visitorPhoneNo}</Cell>
                 <Cell data-label="vehicleNumber">{item.vehicleNumber}</Cell>
                 <Cell data-label="visitDate">{item.visitDate}</Cell>
                 <Cell data-label="isApproved">{item.isApproved.name}</Cell>
                 <Cell data-label="comment">{item.comment}</Cell>
                 <Cell data-label="visitId">{item.visitId}</Cell>
               </Row>
             ))}
           </Body>
         </>
         )}
     </Table>
      </Container>
    );
  } else {
  return (
    <Container>
         <SecurityStaffWelcome/>
    </Container>
  );
  }
}

export default Schedules;
