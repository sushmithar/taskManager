class TaskContainer extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			tasks: []
		};
		this.handleFormSubmit = this.handleFormSubmit.bind(this);
		this.handleDelete = this.handleDelete.bind(this);
		this.handleEdit = this.handleEdit.bind(this);
	}

	handleFormSubmit(params) {
		const body = JSON.stringify({ ...params, "user_id": 1 });
		fetch('/api/v1/tasks/create', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: body,
		}).then((response) => { return response.json() })
			.then((task) => {
				this.addNewTask(task)
			})
	}

	addNewTask(task) {
		const newTask = {
			title: task.title,
			description: task.description,
			status: task.status
		}

		this.setState({ tasks: this.state.tasks.concat(newTask) })
	}

	handleDelete(id) {
		fetch('/api/v1/tasks/destroy/' + id, {
			method: 'DELETE',
			headers: {
				'Content-Type': 'application/json'
			},
		}).then((response) => { return response.json() })
			.then((result) => {
				this.setState({
					tasks: this.state.tasks.filter(task => task.id !== result.id)
				})
			})
	}

	handleEdit(task) {
		console.log("Task to edit is: ", task);
	}

	componentDidMount() {
		fetch('/api/v1/tasks/index')
			.then((response) => { return response.json() })
			.then((data) => { this.setState({ tasks: data }) });
	}

	render() {
		return (
			<div style={{ padding: 10 }}>
				<div style={{ marginBottom: 10 }}>
					<NewTask handleFormSubmit={this.handleFormSubmit}/>
				</div>
				<AllTasks tasks={this.state.tasks} handleDelete={this.handleDelete} handleEdit={this.handleEdit} />
			</div>
		)
	}
}