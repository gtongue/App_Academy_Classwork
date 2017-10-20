# class String
#     def context_constantize( context )
#       name = self
#       context = context.is_a?( Module ) ? context : context.class
  
#       namespaces = context.to_s.split( '::' ).map.with_object([]){ |s, o| o << (o.any? ? o.last.const_get( s ) : Object.const_get(s)) }.reverse
  
#       klass = nil
  
#       namespaces.each do |namespace|
#         if namespace.const_defined?( name )
#           klass = namespace.const_get( name )
#         end
#       end
  
#       klass ? klass : namespaces.first.const_missing( name )
#     end
#   end