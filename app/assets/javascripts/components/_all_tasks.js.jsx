const AllTasks = (props) => {
  if (props.tasks && props.tasks.length > 0) {
    return (
      <table className="table is-bordered is-fullwidth ">
        <thead>
          <tr>
            <th>Title</th>
            <th>Description</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {props.tasks.map((task) => {
            return (
              <tr key={task.id}>
                <td>{task.title}</td>
                <td>{task.description}</td>
                <td>{task.status}</td>
                <td style={{display: "flex", flexDirection:'row', justifyContent:'flex-start'}}>
                  <button className="button" style={{marginRight: 5}} onClick={()=>{
                    props.handleEdit(task);
                  }}>Edit</button>
                  <button className="button" onClick={() => {
                    props.handleDelete(task.id);
                  }}>Delete</button></td>
              </tr>
            )
          })}
        </tbody>
      </table>
    )
  }

  return (<div><p>No tasks available</p></div>)
}