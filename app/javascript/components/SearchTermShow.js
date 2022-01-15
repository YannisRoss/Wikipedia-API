import React from "react"
import PropTypes from "prop-types"
class SearchTermShow extends React.Component {
  constructor(props) {
    super(props)
    

    this.state = {
      searchTerm: this.props.searchTerm,
      currentUser: this.props.currentUser

    };
  }


  render () {
    const {searchTerm,currentUser} = this.props

    return (
      <React.Fragment>
        {console.log(searchTerm)}
        {}
        <h1>{searchTerm.body}</h1>

        <h2>Details</h2>

        <ul>
          <li>Creation timestamp: 
            <p>{searchTerm.created_at}</p></li>

          <li>Edited: 
            {searchTerm.created_at == searchTerm.updated_at ? (
                  <p>Unedited</p>
                
                
                ) : (
                  <p> {searchTerm.updated_at}</p>
                
                
                
                )}
          </li>
          




        </ul>
      </React.Fragment>
    );
  }
}

export default SearchTermShow
