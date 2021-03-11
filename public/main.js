function submitPasteForm(event) 
{
  event.preventDefault();
  const newPasteForm = document.getElementById('paste-form');
  if (newPasteForm.checkValidity()) {
    document.querySelector('input[name=title]').classList.remove('error');
    newPasteForm.submit(); 
  } else {
    document.querySelector('input[name=title]').classList.add('error');
  }
}

function deletePaste(event, id){
  event.preventDefault();
  const response = fetch('/delete/'+id, {
    method: 'POST'
  }).then((response) => {
    window.location.href = '/';
  });
}