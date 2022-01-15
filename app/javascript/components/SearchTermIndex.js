import React from "react"
import PropTypes from "prop-types"

class SearchTermIndex extends React.Component {
  constructor(props) {
    super(props)
    

    this.state = {
      searchTerms: this.props.searchTerms
    };
  }

  render () {
    return (
      <React.Fragment>
        {console.log(this.props)}
        <ul id='terms-list'>
        {this.state.searchTerms.map((term, index) => {
          let hasEditRights = false;
          let creatorData = ''
          if (this.props.currentUser && (term.creator.id == this.props.currentUser.id || this.props.currentUser.id == this.props.admin.id)) {
            hasEditRights = true
            creatorData = 'Created by you!'}
          return ( 
          <div key={index}>        
            <li >{index+1}. {term.body} ({term.entries.length + " entries"}) </li> 
            {hasEditRights ? (
              <div>
                <button onClick={() => this.deleteTerm(term.id, index)}>Delete</button>
                <a href={`http://localhost:3000/search_terms/${term.id}/edit`}>Edit</a>
                <a href={`http://localhost:3000/search_terms/${term.id}`}>Show</a>

              </div>
            ) : (
              <a href={`http://localhost:3000/search_terms/${term.id}`}>Show</a>

            )}

          </div>

          )
        })}
            


        </ul>
      </React.Fragment>
    );
  }

buildList() {

  
}

deleteTerm(id,index) {
  console.log(this.props.searchTerms)
  this.state.searchTerms.splice(index,1)
  console.log(this.props.searchTerms)

  fetch(`http://localhost:3000/search_terms/destroy?id=${id}`)

  {this.setState({
    searchTerms: this.state.searchTerms.concat(this.props.searchTerms)

    
  })}

}

} 

SearchTermIndex.propTypes = {
  searchTerms: PropTypes.array
};
export default SearchTermIndex
