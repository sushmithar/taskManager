const NewTask = (props) => {
	let formFields = {}

	return (
		<form 
		className="is-flex is-flex-direction-row"
		onSubmit={(e) => {
			e.preventDefault();
			props.handleFormSubmit(
				{
					title: formFields.title.value,
					description: formFields.description.value,
					status: formFields.status.value
				}
			);
			e.target.reset();
		}}>
			<input className="input" ref={input => formFields.title = input} placeholder='Task Title' />
			<input className="input" ref={input => formFields.description = input} placeholder='Description' />
			<input className="input" ref={input => formFields.status = input} placeholder='Status' />
			<button type="submit">Submit</button>
		</form>
	)
}