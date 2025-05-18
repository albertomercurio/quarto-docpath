function get_docpath(args, kwargs)
  local absolute = pandoc.utils.stringify(kwargs["absolute"])
  local remove_ext = pandoc.utils.stringify(kwargs["remove_ext"])
  
  local input_file = quarto.doc.input_file
  if remove_ext == "true" then
    input_file, file_ext = pandoc.path.split_extension(input_file)
  end

  if absolute == "true" then
    return pandoc.Str(input_file)
  else
    local proj_root = os.getenv("QUARTO_PROJECT_DIR")
    assert(proj_root and proj_root ~= "",
         "[docpath] QUARTO_PROJECT_DIR is not set – run inside a Quarto project")
    return pandoc.path.make_relative(input_file, proj_root)
  end
end

return {
  ['docpath'] = function(args, kwargs)
    return get_docpath(args, kwargs)
  end
}
