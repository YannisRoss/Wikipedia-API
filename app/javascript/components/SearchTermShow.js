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
    const {searchTerm,creator, entries} = this.props

    return (
      <React.Fragment>
        {console.log(this.props)}
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
          <li>Number of entries:
            <p>{entries.length}
              <ul>
                {entries.map((entry, index) => {

                  return(
                    <div key={index}>
                      <li>{entry.title}</li>
                    </div>
                  )
                  
                })}
              </ul>
            </p>
          </li>

          {this.props.currentUser && (creator.id == this.props.currentUser.id || this.props.currentUser.id == this.props.admin.id) ? (
            <li>Original searcher:
              <p> {creator.email}</p>
            </li>)  : (
            <p></p>
              
            )}
          

            


        </ul>
      </React.Fragment>
    );
  }
}

export default SearchTermShow
