class User < ActiveRecord::Base
  # Hace que el username se arequerido
  validates :username, presence: true, length: { minimum: 3, maximum: 25 },
            # Para hacerlo sensitivo esto uniqueness: true se cambia por
            # Esto ignora el la sensibilidad de caracteres.
            uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length:  {maximum: 105 },
            uniqueness: { case_sensitive: false },
            # Esta forma me valida el formato del correo
            # Suando VALID_EMAIL_REGEX y esto se hace usando regular expresions
            format: { with: VALID_EMAIL_REGEX }



end