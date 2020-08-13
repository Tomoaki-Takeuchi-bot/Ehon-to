$(window).on('load', () => {
  $("input[type=file]").change((e) => {
    $('#image_prev').removeClass('d-none');
    $('#image_present').remove();
    const files = e.currentTarget.files;
    if (files && files[0]) {
      const reader = new FileReader();
      reader.onload = (element) => {
        $('#image_prev').attr('src', element.target.result);
      }
      reader.readAsDataURL(files[0]);
    }
  });
});
